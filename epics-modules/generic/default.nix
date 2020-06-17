{ stdenv, epics-base, patch-configure }:
{ buildInputs ? [ ], installPhase ? "", ... }@args:
let
  newargs = args // {
    buildInputs = [ epics-base patch-configure ] ++ buildInputs;

    configurePhase = ''
      runHook preConfigure
      if [ ! -f "configure/RELEASE.local" ]; then
        echo EPICS_BASE= > configure/RELEASE.local
        for dep in $buildInputs; do
          if [[ "$dep" == *epics* ]]; then
            module="''${dep##*-}"
            if [[ "$module" == "base" ]]; then
              continue
            fi
            module_upper="''${module^^}"
            echo ''${module_upper}= >> configure/RELEASE.local
          fi
        done
        echo "Created RELEASE.local with:"
        cat configure/RELEASE.local
      fi
      # patch release files to point to dependencies
      for path in "configure/RELEASE" "configure/RELEASE.linux-x86_64.Common" "configure/RELEASE.linux-x86_64" "configure/RELEASE.local"; do
        if [ -f "$path" ]; then
          patch-configure "$path"
         fi
      done
      # don't make examples or docs
      if [ -f etc/Makefile ]; then
        sed -i /makeIocs/d etc/Makefile;
        sed -i /makeDocumentation/d etc/Makefile;
      fi
      runHook postConfigure
    '';

    findSrc = builtins.toFile "find-epics" ''
      #!/usr/bin/env bash
      echo @out@
    '';

    buildPhase = "# Dummy, it is done as part of installPhase";

    installPhase = if installPhase == "" then ''
      runHook preInstall
      make INSTALL_LOCATION=$out
      mkdir -p $out/bin
      substituteAll $findSrc $out/bin/find-$name
      chmod +x $out/bin/find-$name
      if [ -d etc ]; then
        cp -rf etc $out
      fi
      runHook postInstall
    '' else
      installPhase;

    meta.priority = 6;
  };
in stdenv.mkDerivation newargs
