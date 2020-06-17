{ fetchgit, buildEpicsModule, epics-pvcommon }:

buildEpicsModule rec {
  name = "dls-epics-pvdata";
  buildInputs = [ epics-pvcommon ];
  version = "8.0.2";
  src = fetchgit {
    url = "https://github.com/epics-base/pvDataCPP.git";
    rev = "${version}";
    sha256 = "117ivf4k8a9r9sz0qkg1i8iaii98fyvfni94xsg3zdgfiv17p5bq";
    fetchSubmodules = false;
  };
}
