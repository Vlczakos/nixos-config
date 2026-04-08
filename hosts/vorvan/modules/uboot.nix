{ pkgsCross, inputs, ... }:
let
  atfCB1 = pkgsCross.buildArmTrustedFirmware {
    platform = "sun50i_h616";
    filesToInstall = [ "build/sun50i_h616/release/bl31.bin" ];
  };

  ubootCB1 = pkgsCross.buildUBoot {
    version = "custom-btt";
    src = inputs.bigtreetech_uboot;
    defconfig = "bigtreetech_cb1_defconfig";
    BL31 = "${atfCB1}/bl31.bin";
    filesToInstall = [ "u-boot-sunxi-with-spl.bin" ];
  };
in
{
  uboot = {
    image = "${ubootCB1}/u-boot-sunxi-with-spl.bin";
    offset = 8192;
  };
}
