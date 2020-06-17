{ fetchgit, buildEpicsModule }:

buildEpicsModule rec {
  name = "epics-sscan";
  version = "2-11-3";
  src = fetchgit {
    url = "https://github.com/epics-modules/sscan.git";
    rev = "R${version}";
    sha256 = "060hqjg7n9irllpnqjpwn39xkw1ldiwqykv95bldag116aljdhhz";
  };
}
