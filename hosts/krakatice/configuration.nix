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
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINkv9uYBtQvd/Z/sWEJzXwbuo6IPE4iBbm2dIAXg1EtQ vlczak@meduza"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEz0M1anq7Uq32EiIQOG9NLkomyS7q7/46yHQZ7lbMcz"
    ];
    # packages = with pkgs; [ ];
  };
  home-manager.users.vlczak.imports = [ ./home.nix ];

  services.autossh.sessions = [
    {
      monitoringPort = 20000;
      name = "oracle-tunnel";
      user = "vlczak";
      extraArguments = "-i ~/.ssh/id_ed25519_ssh_tunnel -N -R 25565:localhost:25565 -R 22222:localhost:22 -R 1234:localhost:80 -R 8080:localhost:8080 -R 24455:localhost:24455 ubuntu@130.162.230.214";
    }
  ];

  systemd.services.socat = {
    description = "Socat UDP tunnel service";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      ExecStart = "${lib.getExe pkgs.socat} TCP-LISTEN:24455,fork UDP:localhost:24454";
      Restart = "always";
      RestartSec = "10";
    };
    wantedBy = [ "multi-user.target" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
