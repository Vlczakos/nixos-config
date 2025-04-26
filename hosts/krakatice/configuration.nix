{
  ...
}:

{
  imports = [
    ./hardware-configuration.nix

    ./../../modules/nixos/shared
    ./../../modules/nixos/servers/minecraft.nix
    ./../../modules/nixos/servers/ssh.nix
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
    ];
    # packages = with pkgs; [ ];
  };
  home-manager.users.vlczak.imports = [ ./home.nix ];

  services.autossh.sessions = [
    {
      name = "oracle-tunnel";
      user = "vlczak";
      extraArguments = "-i ~/.ssh/id_ed25519_ssh_tunnel -N -R 25565:localhost:25565 -R 22222:localhost:22 ubuntu@130.162.230.214";
    }
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
