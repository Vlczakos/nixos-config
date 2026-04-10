{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.custom.system.graphic_drivers.intel;
in
{
  options.custom.system.graphic_drivers.intel = {
    enable = lib.mkEnableOption "Intel";
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        libglvnd
        mesa

        intel-media-driver
        intel-vaapi-driver
        libvdpau-va-gl

        vpl-gpu-rt # for newer GPUs on NixOS >24.05 or unstable
        # onevpl-intel-gpu  # for newer GPUs on NixOS <= 24.05
        # intel-media-sdk   # for older GPUs
      ];
    };

    environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
  };
}
