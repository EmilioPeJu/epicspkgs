{ fetchgit, pcre, readline, git, buildEpicsModule, epics-asyn }:

buildEpicsModule rec {
  name = "epics-streamdevice";
  buildInputs = [ pcre readline git epics-asyn ];
  version = "2.8.14";
  src = fetchgit {
    url = "https://github.com/paulscherrerinstitute/StreamDevice.git";
    rev = "${version}";
    sha256 = "0j4rj3pvc02ridz12zqkj3iiqnzavn38nhf52fi8g8dq8908ypm4";
    leaveDotGit = true;
  };
  patches = [ ./fix-version-discovery.patch ];
  postConfigure = ''
    oldIFS="$IFS"
    IFS='.'
    read -a ver <<<"$version"
    IFS="$oldIFS"
    cat << EOF > src/StreamVersion.h
    #ifndef StreamVersion_h
    #define StreamVersion_h
    #define STREAM_MAJOR ''${ver[0]}
    #define STREAM_MINOR ''${ver[1]}
    #define STREAM_PATCHLEVEL ''${ver[2]}
    #define STREAM_DEV ""
    #endif /* StreamVersion_h */
    EOF
    cat << EOF > configure/CONFIG
    include \$(TOP)/configure/CONFIG_APP
    PCRE_LIB=${pcre.out}/lib
    PCRE_INCLUDE=${pcre.dev}/include
    EOF
  '';
}
