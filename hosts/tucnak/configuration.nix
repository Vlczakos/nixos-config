{
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix

    ./../../modules/nixos/gui

    ./../../modules/nixos/shared

    ./../../modules/nixos/graphic_drivers/intel.nix
  ];

  networking.hostName = "tucnak"; # Define your hostname.

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

  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.20.30.100/24" ];
      privateKeyFile = "/etc/wg-keys/private";

      peers = [
        {
          publicKey = "Ci6a5eHofzrr10zAF2N/zFez/PjBERGu/0povFlNfCo=";
          allowedIPs = [ "10.20.30.0/24" ];
          endpoint = "vlcak.com:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };

  networking.firewall.interfaces."wg0" = {
    allowedTCPPorts = [ 22000 ];
    allowedUDPPorts = [ 22000 ];
  };

  # disable tpm2 - not used and startup service timed out several times
  systemd.tpm2.enable = false;
  boot.initrd.systemd.tpm2.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
