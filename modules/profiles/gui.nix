{ lib, config, ... }:
{
  options.custom.profiles.gui = lib.mkEnableOption "Gui profile";

  config = lib.mkIf config.custom.profiles.gui {
    custom = {
      apps.gui = {
        thunar.enable = true;
      };
      themes.gui.enable = true;
    };

    home-manager.sharedModules = [
      {
        custom = {
          apps.gui = {
            bundle.enable = true;
            vscode.enable = true;
          };
          desktop = {
            hyprland.enable = true;
            dunst.enable = true;
            hyprlock.enable = true;
            waybar.enable = true;
            xdg.enable = true;
          };
        };
      }
    ];
  };
}
