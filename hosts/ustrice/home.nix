{ ... }:
{
  imports = [
    ./../../modules/home_manager/gui

    # ./../../modules/home_manager/gui/davinci_resolve.nix
    ./../../modules/home_manager/gui/games.nix
  ];

  home.username = "vlczak";
  home.homeDirectory = "/home/vlczak";

  wayland.windowManager.hyprland.settings.monitor = [
    "HDMI-A-3,1920x1080@60.00Hz,0x0,1"
    "DP-2,3440x1440@175.00Hz,0x0,1"
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
}
