{ fetchgit, buildEpicsModule, epics-pvcommon, epics-pvdata }:

buildEpicsModule rec {
  name = "epics-normativetypes";
  buildInputs = [ epics-pvcommon epics-pvdata ];
  version = "6.0.1";
  src = fetchgit {
    url = "https://github.com/epics-base/normativeTypesCPP.git";
    rev = "${version}";
    sha256 = "0z037f6ad8fz1pp6b3q693nn21k3kpkq1ywbzb95wp6lap0fs6rl";
  };
}
