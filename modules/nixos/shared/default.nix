{ pkgs, inputs, ... }:
{
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./bootloader.nix
    ./home_manager.nix
    ./locale.nix
    ./packages.nix
    ./shell.nix
    ./docker.nix
    ./themes
  ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.vscode-extensions.overlays.default
    ];
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      fuse3
      icu
      nss
      openssl
      curl
      expat
    ];
  };

  services.gvfs.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.networkmanager = {
    enable = true;
    plugins = [
      pkgs.networkmanager-openvpn
    ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandlePowerKey = "ignore";
  };
}
