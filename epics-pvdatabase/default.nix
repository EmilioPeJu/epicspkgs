{ fetchgit, buildEpicsModule, epics-pvcommon, epics-pvdata, epics-pvaccess }:

buildEpicsModule rec {
  name = "epics-pvdatabase";
  buildInputs = [ epics-pvcommon epics-pvdata epics-pvaccess ];
  version = "4.5.2";
  src = fetchgit {
    url = "https://github.com/epics-base/pvDatabaseCPP.git";
    rev = "${version}";
    sha256 = "0vc29c5mcnv13py2a7mhriac3nxhi3fvlswrz2icaqr4834kf3z6";
    fetchSubmodules = false;
  };
}
