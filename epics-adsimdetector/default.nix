{ fetchgit, libxml2, buildEpicsModule, epics-asyn, epics-adcore }:

buildEpicsModule rec {
  name = "epics-adsimdetector";
  version = "2-10";
  buildInputs = [ libxml2 epics-asyn epics-adcore ];
  src = fetchgit {
    url = "https://github.com/areaDetector/ADSimDetector.git";
    rev = "R${version}";
    sha256 = "0f9gxlnvgva44499bxjdvs06yxx2xjs55x2xq4ls6wzfpsr717rq";
  };
}
