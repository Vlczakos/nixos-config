{
  ...
}:
let

in
{
  imports = [
    ../../modules

    ./modules/uboot.nix
    ./modules/kernel.nix
  ];

  custom.profiles.core = true;

  custom.services.ssh.enable = true;

  networking.hostName = "vorvan";

  users.users.vlczak = {
    isNormalUser = true;
    description = "David Vlcek";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAOmGi1vEdJN6OGHn6sRGfzxpT3eA+aL+mVfz54E6MfI vlczak@ustrice"
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
        interface-name = "end0";
        autoconnect = true;
      };

      ipv4 = {
        method = "manual";
        addresses = "192.168.1.60/24";
        gateway = "192.168.1.1";
        dns = "192.168.1.70";
      };
    };
  };

  networking.wg-quick.interfaces = {
    wg0 = {
      mtu = 1380;

      address = [ "10.20.30.60/24" ];
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

  system.stateVersion = "24.05";
}
