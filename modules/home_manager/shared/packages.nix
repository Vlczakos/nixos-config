{ pkgs, ... }:

{
  home.packages = with pkgs; [
    brightnessctl
    pamixer
    openvpn
  ];

  programs.kitty = {
    enable = true;

    settings = {
      window_padding_width = 4;

      placement_strategy = "top-left";
    };
  };
}
