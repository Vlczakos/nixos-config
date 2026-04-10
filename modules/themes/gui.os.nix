{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.custom.themes.gui.enable = lib.mkEnableOption "gui themes";

  config = lib.mkIf config.custom.themes.gui.enable {
    stylix = {
      image =
        if config.networking.hostName == "tucnak" then
          ./wallpapers/svestkova_draha.jpg
        else
          ./wallpapers/nix-binary.png;

      icons = {
        enable = true;
        package = pkgs.papirus-icon-theme; # .override { color = "bluegrey"; };
        dark = "Papirus-Dark";
        light = "Papirus-Light";
      };

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 19;
      };
    };
  };
}
