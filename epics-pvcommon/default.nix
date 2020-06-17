{ fetchgit, buildEpicsModule }:

buildEpicsModule rec {
  name = "epics-pvcommon";
  version = "4.2.3";
  src = fetchgit {
    url = "https://github.com/epics-base/pvCommonCPP.git";
    rev = "${version}";
    sha256 = "16wijishs8l4bdr69vdblmmcvbsxwfmmq0q12mx9q606iv60idj8";
    fetchSubmodules = false;
  };
}
