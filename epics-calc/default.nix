{ fetchgit, buildEpicsModule }:

buildEpicsModule rec {
  name = "epics-calc";
  version = "3-7-4";
  src = fetchgit {
    url = "https://github.com/epics-modules/calc.git";
    rev = "R${version}";
    sha256 = "14kbrv72cfsavvk5la3m33h9cbhia1n6lywh0ng300qqmlrkv43i";
  };
}
