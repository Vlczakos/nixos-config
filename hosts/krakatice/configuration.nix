{
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix

    ./../../modules/nixos/shared

    ./../../modules/nixos/servers/minecraft.nix
    ./../../modules/nixos/servers/ssh.nix
    ./../../modules/nixos/servers/web_server.nix
  ];

  networking.hostName = "krakatice"; # Define your hostname.

  users.users.vlczak = {
    isNormalUser = true;
    description = "David Vlcek";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "minecraft"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAOmGi1vEdJN6OGHn6sRGfzxpT3eA+aL+mVfz54E6MfI vlczak@ustrice"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEz0M1anq7Uq32EiIQOG9NLkomyS7q7/46yHQZ7lbMcz"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMM2ILrcyKxtrmDh80B5VHkzIyhPe/se19LAmsKklGvv vlczak@tucnak"
    ];
    # packages = with pkgs; [ ];
  };
  home-manager.users.vlczak.imports = [ ./home.nix ];

  networking = {
    firewall = {
      allowedTCPPorts = [
        8080  # mc map
        25565 # mc server

        22000 # syncthing
      ];
      allowedUDPPorts = [
        24454 # mc voice chat
        51820 # vpn
      ];
    };
  };

  networking.networkmanager.ensureProfiles.profiles = {
    "static-ethernet" = {
      connection = {
        id = "static-ethernet";
        type = "ethernet";
        interface-name = "eno1";
        autoconnect = true;
      };

      ipv4 = {
        method = "manual";
        addresses = "192.168.1.90/24";
        gateway = "192.168.1.1";
        dns = "192.168.1.70";
      };
    };
  };

  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.20.30.90/24" ];
      listenPort = 51820;
      privateKeyFile = "/etc/wg-keys/private";

      peers = [
        {
          publicKey = "Ci6a5eHofzrr10zAF2N/zFez/PjBERGu/0povFlNfCo="; # nemo
          allowedIPs = [ "10.20.30.70/32" ];
        }
        {
          publicKey = "CO45n+A8ScbJOluSC9chq4x6jWIUYGPr+0CFyDF6hXo="; # ustrice
          allowedIPs = [ "10.20.30.80/32" ];
        }
        {
          publicKey = "Fp6fCOgPSeTKZmg/2QT5zG33NzVJfHrl4NOd2fVqfw8="; # tucnak
          allowedIPs = [ "10.20.30.100/32" ];
        }
        {
          publicKey = "4B8Z66WcxGORKiPVp4TFOYgKf3rABXS5PQqhfJUwqzM="; # nothing 2A
          allowedIPs = [ "10.20.30.101/32" ];
        }
      ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
