{ fetchgit, aravis, wget, glib, libxml2, zlib, pkg-config, intltool
, buildEpicsModule, epics-asyn, epics-adcore }:

buildEpicsModule {
  name = "epics-aravisgige";
  buildInputs = [
    aravis
    wget
    pkg-config
    glib
    libxml2.dev
    zlib
    intltool
    epics-asyn
    epics-adcore
  ];
  src = builtins.fetchGit {
    url = "https://github.com/areaDetector/aravisGigE.git";
    rev = "0722a4cf65d3b468e7df5a7d80bb6576cb75e7b3";
  };
  patches = [ ./lib-to-syslib.patch ];
  postConfigure = ''
    cat << EOF >> configure/CONFIG_SITE
    CHECK_RELEASE = YES
    GLIBPREFIX=${glib.out}
    GLIBDEVPREFIX=${glib.dev}
    ARAVIS_INCLUDE=${aravis.dev}/include/aravis-0.6
    ARAVIS_LIB=${aravis.lib}/lib
    USR_INCLUDES += -I\$(GLIBPREFIX)/lib/glib-2.0/include  -I\$(GLIBDEVPREFIX)/include/glib-2.0
    EOF
  '';
  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -rf * $out
    cd $out
    make
    rm -rf aravisGigEApp
    find . \( -name '*.c' -or -name '*.cc' -or -name '*.cpp' -or -name '*.o' \) -exec rm {} \;
    runHook postInstall
  '';
}
