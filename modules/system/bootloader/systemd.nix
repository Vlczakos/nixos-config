{ lib, config, ... }:
{
  options.custom.system.bootloader.systemd = {
    enable = lib.mkEnableOption "systemd";
  };

  config = lib.mkIf config.custom.system.bootloader.systemd.enable {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
