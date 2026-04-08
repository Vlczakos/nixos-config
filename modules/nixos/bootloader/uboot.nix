{ lib, config, ... }:
{
  options = {
    uboot = {
      image = lib.mkOption {
        description = "Path to image .bin file.";

        type = lib.types.str;
      };

      offset = lib.mkOption {
        description = "Where to write the image.";

        type = lib.types.int;
      };
    };
  };

  config = {
    boot.loader.grub.enable = false;
    boot.loader.generic-extlinux-compatible.enable = true;

    sdImage = {
      firmwareSize = 256;

      populateFirmwareCommands = lib.mkForce ''
        ${config.boot.loader.generic-extlinux-compatible.populateCmd} -c ${config.system.build.toplevel} -d ./firmware
      '';

      postBuildCommands = ''
        dd if=${config.uboot.image} of=$img seek=1 bs=${lib.toString config.uboot.offset} conv=notrunc
      '';
      compressImage = false;
    };
  };
}
