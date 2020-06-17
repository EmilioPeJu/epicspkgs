{ fetchgit, libxml2, buildEpicsModule, epics-asyn, epics-busy, epics-sscan
, epics-calc, epics-pvdata, epics-normativetypes, epics-pvaccess
, epics-pvdatabase, hdf5, boost, c-blosc, libtiff }:

buildEpicsModule rec {
  name = "epics-adcore";
  version = "3-9";
  src = fetchgit {
    url = "https://github.com/areaDetector/ADCore.git";
    rev = "R${version}";
    sha256 = "0l8l1j37l7m19892wiki6c0f8f8b3qln5js2pdp3szwirljww2sy";
  };
  buildInputs = [
    libxml2.dev
    epics-asyn
    epics-busy
    epics-sscan
    epics-calc
    epics-pvdata
    epics-normativetypes
    epics-pvaccess
    epics-pvdatabase
    hdf5
    boost
    c-blosc
    libtiff
  ];
  preConfigure = ''
    cat << EOF > configure/CONFIG_SITE.linux-x86_64.Common
    WITH_HDF5 = YES
    HDF5_EXTERNAL = YES
    WITH_BOOST = YES
    BOOST_EXTERNAL = YES
    WITH_XML2     = YES
    XML2_EXTERNAL = YES
    XML2_INCLUDE = ${libxml2.dev}/include/libxml2
    WITH_BLOSC    = YES
    BLOSC_EXTERNAL= YES
    #WITH_JPEG = YES
    #JPEG_EXTERNAL = NO
    WITH_TIFF     = YES
    TIFF_EXTERNAL = YES
    #WITH_ZLIB     = YES
    #ZLIB_EXTERNAL = NO
    #WITH_SZIP = YES
    #SZIP_EXTERNAL = NO
    # Enable PVA plugin
    WITH_PVA = YES
    WITH_QSRV     = NO
    EOF
  '';
  postInstall = ''
    mkdir -p $out/ADApp
    cp ADApp/common*Makefile $out/ADApp
  '';
}
