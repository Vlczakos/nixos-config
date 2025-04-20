{ ... }:
{
  imports = [
    ./packages.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./xdg.nix
    ./fish.nix
    ./themes.nix
    ./vscode.nix
    ./fastfetch.nix
    ./btop.nix
    ./waybar.nix
    ./nh.nix
    ./kitty.nix
    ./dunst.nix
    ./mangohud.nix
    ./git.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}