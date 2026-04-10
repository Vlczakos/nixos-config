{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.system.graphic_drivers.nvidia;
in
{
  options.custom.system.graphic_drivers.nvidia = {
    enable = lib.mkEnableOption "Nvidia";
    prime = lib.mkEnableOption "Prime";

    intelBusId = lib.mkOption {
      type = lib.types.str;
      default = "PCI:0@0:2:0";
      description = "Bus ID";
    };
    
    nvidiaBusId = lib.mkOption {
      type = lib.types.str;
      default = "PCI:1@0:0:0";
      description = "Bus ID";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libglvnd
      mesa
    ];

    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = [ "nvidia" ];

    boot.kernelParams = [ "nvidia-drm.fbdev=1" ];

    hardware.graphics.enable = true;

    hardware.nvidia = lib.mkMerge [
      {
        open = true;
        nvidiaSettings = true;
      }
      (lib.mkIf cfg.prime {
        prime = {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };

          intelBusId = cfg.intelBusId;
          nvidiaBusId = cfg.nvidiaBusId;
        };

        powerManagement.enable = true;
        powerManagement.finegrained = true;
      })
    ];

    environment.variables = {
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia_drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };
}
