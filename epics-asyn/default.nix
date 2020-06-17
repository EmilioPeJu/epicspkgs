{ fetchgit, buildEpicsModule, doxygen }:

buildEpicsModule rec {
  name = "epics-asyn";
  buildInputs = [ doxygen ];
  version = "4-39";
  src = fetchgit {
    url = "https://github.com/epics-modules/asyn.git";
    rev = "R${version}";
    sha256 = "0qkpapi1wxgb2692qnch1zy8rc030aidwmrmlq50chzjf2ycp2xi";
  };
}
