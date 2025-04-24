{ ... }:
{
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./bootloader.nix
    ./home_manager.nix
    ./locale.nix
    ./packages.nix
    ./shell.nix
  ];

  nixpkgs.config.allowUnfree = true;
  services.gvfs.enable = true;
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];

  services.logind = {
    lidSwitch = "ignore";
    powerKey = "ignore";
  };
}
