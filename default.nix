{ pkgs ? import (fetchTarball
  "https://github.com/NixOS/nixpkgs-channels/archive/nixos-20.03.tar.gz") { } }:
with pkgs; rec {
  buildEpicsModule =
    callPackage ./epics-modules/generic { inherit epics-base patch-configure; };
  epics-base = callPackage ./epics-base { };
  patch-configure = callPackage ./patch-configure { };
  epics-sscan = callPackage ./epics-sscan { inherit buildEpicsModule; };
  epics-calc = callPackage ./epics-calc { inherit buildEpicsModule; };
  epics-asyn = callPackage ./epics-asyn { inherit buildEpicsModule; };
  epics-busy =
    callPackage ./epics-busy { inherit buildEpicsModule epics-asyn; };
  epics-pvcommon = callPackage ./epics-pvcommon { inherit buildEpicsModule; };
  epics-pvdata =
    callPackage ./epics-pvdata { inherit buildEpicsModule epics-pvcommon; };
  epics-normativetypes = callPackage ./epics-normativetypes {
    inherit buildEpicsModule epics-pvcommon epics-pvdata;
  };
  epics-pvaccess = callPackage ./epics-pvaccess {
    inherit buildEpicsModule epics-pvcommon epics-pvdata;
  };
  epics-pvdatabase = callPackage ./epics-pvdatabase {
    inherit buildEpicsModule epics-pvcommon epics-pvdata epics-pvaccess;
  };
  epics-pvaclient = callPackage ./epics-pvaclient {
    inherit buildEpicsModule epics-pvdata epics-normativetypes epics-pvaccess;
  };
  epics-adcore = callPackage ./epics-adcore {
    inherit buildEpicsModule epics-asyn epics-busy epics-sscan epics-calc
      epics-pvdata epics-normativetypes epics-pvaccess epics-pvdatabase;
  };
  epics-adsimdetector = callPackage ./epics-adsimdetector {
    inherit buildEpicsModule epics-asyn epics-adcore;
  };
  epics-ffmpegserver = callPackage ./epics-ffmpegserver {
    inherit buildEpicsModule epics-asyn epics-adcore epics-adsimdetector;
  };
  epics-aravisgige = callPackage ./epics-aravisgige {
    inherit buildEpicsModule epics-asyn epics-adcore;
  };
  epics-streamdevice =
    callPackage ./epics-streamdevice { inherit buildEpicsModule epics-asyn; };
  epics-seq = callPackage ./epics-seq { inherit buildEpicsModule; };
  epics-motor = callPackage ./epics-motor {
    inherit buildEpicsModule epics-busy epics-asyn;
  };
  epics-pmac = callPackage ./epics-pmac {
    inherit buildEpicsModule epics-calc epics-busy epics-asyn epics-motor;
  };
  epics-adpython = callPackage ./epics-adpython {
    inherit buildEpicsModule epics-asyn epics-adcore;
  };
  edm = callPackage ./edm { inherit epics-base patch-configure; };
  epics-all = buildEnv {
    name = "epics-all";
    ignoreCollisions = true;
    pathsToLink = [ "/bin" ];
    paths = [
      patch-configure
      epics-base
      epics-seq
      epics-sscan
      epics-asyn
      epics-calc
      epics-busy
      epics-pvcommon
      epics-pvdata
      epics-normativetypes
      epics-pvaccess
      epics-pvdatabase
      epics-pvaclient
      epics-adcore
      epics-streamdevice
      epics-motor
      epics-pmac
      epics-adsimdetector
      epics-adpython
      epics-aravisgige
      epics-ffmpegserver
      edm
    ];
  };
}
