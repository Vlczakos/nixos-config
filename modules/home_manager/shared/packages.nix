{ pkgs, ... }:

{
  home.packages = with pkgs; [
    brightnessctl
    pamixer
  ];

  programs.kitty = {
    enable = true;
  };
}
