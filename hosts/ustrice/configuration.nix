{
  # pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix

    ./../../modules/nixos/gui

    ./../../modules/nixos/gui/steam.nix
    ./../../modules/nixos/gui/saleae-logic.nix
    ./../../modules/nixos/gui/vmware.nix

    ./../../modules/nixos/graphic_drivers/nvidia.nix
    ./../../modules/nixos/shared

    ./../../modules/nixos/servers/ssh.nix
    ./../../modules/nixos/servers/sunshine.nix
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

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEz0M1anq7Uq32EiIQOG9NLkomyS7q7/46yHQZ7lbMcz"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMM2ILrcyKxtrmDh80B5VHkzIyhPe/se19LAmsKklGvv vlczak@tucnak"
    ];
    # packages = with pkgs; [ ];
  };
  home-manager.users.vlczak.imports = [ ./home.nix ];

  networking.networkmanager.ensureProfiles.profiles = {
    "static-ethernet" = {
      connection = {
        id = "static-ethernet";
        type = "ethernet";
        interface-name = "enp5s0";
        autoconnect = true;
      };

      ipv4 = {
        method = "manual";
        addresses = "192.168.1.80/24";
        gateway = "192.168.1.1";
        dns = "192.168.1.70";
      };
    };
  };

  networking.interfaces.enp5s0.wakeOnLan.enable = true;

  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.20.30.80/24" ];
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
