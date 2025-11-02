{
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix

    ./../../modules/nixos/gui
    
    ./../../modules/nixos/gui/steam.nix
    # ./../../modules/nixos/gui/saleae-logic.nix
    # ./../../modules/nixos/gui/vmware.nix

    ./../../modules/nixos/graphic_drivers/nvidia.nix
    ./../../modules/nixos/shared
  ];

  networking.hostName = "ustrice"; # Define your hostname.

  users.users.vlczak = {
    isNormalUser = true;
    description = "David Vlcek";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "plugdev"
    ];
    # packages = with pkgs; [ ];
  };
  home-manager.users.vlczak.imports = [ ./home.nix ];

  services.getty = {
    autologinUser = "vlczak";
    autologinOnce = true;
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="df11", MODE="0666", GROUP="plugdev"
  '';  

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
