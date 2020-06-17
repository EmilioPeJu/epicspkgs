{ fetchgit, boost, libssh2, buildEpicsModule, epics-calc, epics-busy, epics-asyn
, epics-motor }:

buildEpicsModule rec {
  name = "epics-pmac";
  buildInputs = [ boost libssh2 epics-calc epics-busy epics-asyn epics-motor ];
  version = "2-4-10";
  src = fetchgit {
    url = "https://github.com/dls-controls/pmac.git";
    rev = "refs/tags/${version}";
    sha256 = "0013xrx0cf90cxyjz32za2lqs56ihj6k5jj7hjardl2yq3wr2gf1";
  };
  NIX_CFLAGS_COMPILE = "-Wno-error=format-security";
  patches = [ ./disable-tests.patch ];
}
