{ ... }:
{
  imports = [
    ./packages.nix
    ./fish.nix
    ./fastfetch.nix
    ./btop.nix
    ./nh.nix
    ./git.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
