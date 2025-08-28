{ pkgs, ... }:

{
  home.packages = with pkgs; [
    brightnessctl
    pamixer
    openvpn
  ];

  programs.kitty = {
    enable = true;
  };
}
