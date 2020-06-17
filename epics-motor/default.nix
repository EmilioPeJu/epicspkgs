{ fetchurl, buildEpicsModule, epics-busy, epics-asyn }:

buildEpicsModule rec {
  name = "epics-motor";
  buildInputs = [ epics-busy epics-asyn ];
  version = "7-2-1";
  src = fetchurl {
    url = "https://github.com/epics-modules/motor/archive/R${version}.tar.gz";
    sha256 = "0dwy7y5ixhi15mmw1cx9qdk1ci62f89r66lzg0b7cylaqvgn7w8v";
  };
}
