{ fetchgit, readline, libxml2, ffmpeg-full, buildEpicsModule, epics-asyn
, epics-adcore, epics-adsimdetector }:

buildEpicsModule {
  name = "epics-ffmpegserver";
  buildInputs = [
    readline
    libxml2.dev
    ffmpeg-full
    epics-asyn
    epics-adcore
    epics-adsimdetector
  ];
  patches = [ ./use-sys-libs.patch ];
  src = fetchgit {
    url = "https://github.com/areaDetector/ffmpegServer.git";
    rev = "063bedd082aa4c13be50ca127eecd57cec1188d9";
    sha256 = "1nid2d65ljw0r7yzxb9wa654dgd1sswjn6nfacrwim9k0kcxhd5x";
  };
}
