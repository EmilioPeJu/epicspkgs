{ fetchgit, buildEpicsModule, epics-pvcommon, epics-pvdata }:

buildEpicsModule rec {
  name = "epics-pvaccess";
  buildInputs = [ epics-pvcommon epics-pvdata ];
  version = "7.1.1";
  src = fetchgit {
    url = "https://github.com/epics-base/pvAccessCPP.git";
    rev = "${version}";
    sha256 = "1l3k2vq8jm5rhld7id6cp1zan6hfcglmxqd7rh8klb3ys54v14qk";
    fetchSubmodules = false;
  };
}
