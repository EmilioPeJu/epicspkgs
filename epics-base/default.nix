{ fetchgit, stdenv, perl }:

stdenv.mkDerivation rec {
  name = "epics-base";
  version = "7.0.4";
  src = fetchgit {
    url = "https://github.com/epics-base/epics-base.git";
    rev = "R${version}";
    sha256 = "1r8frq41dsyhvah4czqysz4wszix4gn4whfrcvjxqnf8c1gni3xi";
    fetchSubmodules = false;
  };

  phases = [ "unpackPhase" "patchPhase" "installPhase" "fixupPhase" ];

  patches = [ ./no_abs_path_to_cc.patch ];

  propagatedBuildInputs = [ perl ];

  setupHook = builtins.toFile "setupHook.sh" ''
    export EPICS_BASE='@out@'
  '';

  findSrc = builtins.toFile "find-epics" ''
    #!/usr/bin/env bash
    echo @out@
  '';

  configurePhase = "# nothing to do";
  buildPhase = ''
    # Dummy build phase, as it is done as part of installPhase
  '';

  installPhase = ''
    make INSTALL_LOCATION=$out
    substituteAll $findSrc $out/bin/find-$name
    chmod +x $out/bin/find-$name
    cd $out/bin
    for i in linux-x86_64/*; do
        ln -s "$i"
    done
  '';

  meta.priority = 4;
}
