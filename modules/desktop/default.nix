{ ... }:
{
  imports = [
    ./hyprland
  ];

  home-manager.sharedModules = [
    ./dunst.hm.nix
    ./hyprlock.hm.nix
    ./waybar.hm.nix
    ./xdg.hm.nix
  ];
}