{ fetchgit, re2c, buildEpicsModule }:

buildEpicsModule rec {
  name = "epics-seq";
  buildInputs = [ re2c ];
  version = "2-2-8";
  src = fetchgit {
    url =
      "http://www-csr.bessy.de/control/SoftDist/sequencer/repo/branch-2-2.git";
    rev = "R${version}";
    sha256 = "1bzl86wv15jx2q1i5ax3cz37gv736yg3h1fcjs5dhy9klhw613ya";
  };
}
