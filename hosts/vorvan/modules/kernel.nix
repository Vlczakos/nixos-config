{ lib, pkgs, pkgsCross, inputs, ... }:
let
  kernelCB1 =
    (pkgsCross.linuxManualConfig {
      version = "6.6.66-bigtreetech";
      modDirVersion = "6.6.66";
      src = inputs.bigtreetech_kernel;
      configfile = ./kernel.config;
    }).overrideAttrs
      (old: {
        nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.buildPackages.ubootTools ];
      });
in
{
  boot.kernelPackages = lib.mkForce (pkgsCross.linuxPackagesFor kernelCB1);
  hardware.deviceTree.enable = true;
  hardware.deviceTree.name = "allwinner/sun50i-h616-bigtreetech-cb1-sd.dtb";

  boot.kernelParams = [
    "console=tty1"
    "console=ttyS0,115200"
    "rootwait"
  ];

  hardware.enableRedistributableFirmware = true;

  nixpkgs.overlays = [
    (self: super: {
      makeModulesClosure = x: super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];
}
