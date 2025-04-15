{ pkgs, ... }:

{
  home.packages = with pkgs; [
    brave
    vesktop
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
