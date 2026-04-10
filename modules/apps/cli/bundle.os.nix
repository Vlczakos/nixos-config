{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.custom.apps.cli.bundle = {
    enable = lib.mkEnableOption "Default apps bundle";
  };

  config = lib.mkIf config.custom.apps.cli.bundle.enable {
    environment.systemPackages = with pkgs; [
      #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      #  wget
      killall
      git
      usbutils
      sshfs
      waypipe
      ouch
    ];

    programs.dconf.enable = true;
    programs.direnv.enable = true;
    programs.tmux = {
      enable = true;
      extraConfig = "set -g mouse on";
    };
  };
}
