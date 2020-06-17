{ fetchgit, buildEpicsModule, epics-pvdata, epics-normativetypes, epics-pvaccess
}:

buildEpicsModule rec {
  name = "epics-pvaclient";
  buildInputs = [ epics-pvdata epics-normativetypes epics-pvaccess ];
  version = "4.7.1";
  src = fetchgit {
    url = "https://github.com/epics-base/pvaClientCPP.git";
    rev = "${version}";
    sha256 = "03hn68cp3sxjzkz4xfhlmzpx2bi3asslf16ikkx5mbfc2jqf01km";
    fetchSubmodules = false;
  };
}
