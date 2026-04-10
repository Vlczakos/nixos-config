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
    programs.git = {
      enable = true;

      signing.format = "openpgp";

      settings.user = {
        email = "david@vlcak.com";
        name = "Vlczakos";
      };
    };

    programs.nh = {
      enable = true;
      flake = "/nixos-config";
    };

    home.packages = with pkgs; [
      brightnessctl
      pamixer
      openvpn
    ];
  };
}
