{ ... }:
{
  imports = [
    ./bootloader/systemd.nix
    ./bootloader/uboot.nix

    ./graphic_drivers/intel.nix
    ./graphic_drivers/nvidia.nix

    ./core.nix
    ./home_manager.nix
  ];
}