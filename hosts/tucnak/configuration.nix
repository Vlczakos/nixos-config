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

    ./../../modules/nixos/servers/syncthing.nix
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
          publicKey = "SfLorxq/7wKXr+NQ498zcPFYr0UrraolfITXJKcDmlM=";
          allowedIPs = [ "10.20.30.0/24" ];
          endpoint = "vlcak.com:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };

  services.syncthing.settings.folders = {
    "/sync/test_sync" = {
      id = "test_sync";
      devices = [ "krakatice" ];
    };
  };

  systemd.tmpfiles.rules = [
    "d /sync/test_sync 0770 vlczak syncthing -"
    "L /home/vlczak/test_sync - - - - /sync/test_sync"
  ];

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
