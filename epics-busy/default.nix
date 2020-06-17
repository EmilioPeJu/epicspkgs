{ fetchgit, buildEpicsModule, epics-asyn }:

buildEpicsModule rec {
  name = "epics-busy";
  buildInputs = [ epics-asyn ];
  version = "1-7-2";
  src = fetchgit {
    url = "https://github.com/epics-modules/busy.git";
    rev = "R${version}";
    sha256 = "1c9y2f1p0rj8fyfb13162w0sbbg403i4rbwji7g47yd2y0y8gpj7";
  };
}
