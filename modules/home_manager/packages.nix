{ pkgs, ... }:

{
  home.packages = with pkgs; [
    brave
    vesktop
    xfce.thunar
    xfce.thunar-archive-plugin
    prismlauncher
    betaflight-configurator

    brightnessctl
    pamixer
    xdg-utils
    networkmanagerapplet
    pavucontrol
    swww
    grimblast
    dconf
    hyprpolkitagent
  ];

  services.playerctld.enable = true;
}
