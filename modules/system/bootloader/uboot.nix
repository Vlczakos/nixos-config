{ lib, config, options, ... }:
let
  cfg = config.custom.system.bootloader.uboot;
in
{
  options.custom.system.bootloader.uboot = {
    enable = lib.mkEnableOption "U-boot";
    image = lib.mkOption { type = lib.types.path; };
    offset = lib.mkOption { type = lib.types.int; };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      boot.loader.generic-extlinux-compatible.enable = true;
    }
    
    (lib.optionalAttrs (options ? sdImage) {
      sdImage = {
        firmwareSize = 256;
        populateFirmwareCommands = lib.mkForce ''
          ${config.boot.loader.generic-extlinux-compatible.populateCmd} -c ${config.system.build.toplevel} -d ./firmware
        '';
        postBuildCommands = ''
          dd if=${cfg.image} of=$img seek=1 bs=${lib.toString cfg.offset} conv=notrunc
        '';
        compressImage = false;
      };
    })
  ]);
}