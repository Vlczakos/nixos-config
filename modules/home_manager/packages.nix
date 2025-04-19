{ pkgs, ... }:

{
  home.packages = with pkgs; [
    brave
    vesktop
    prismlauncher
    kdePackages.okular
    xournalpp
    vlc

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
