{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nerd-fonts.bitstream-vera-sans-mono
    noto-fonts-color-emoji
  ];

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 19;

    x11.enable = true;
    gtk.enable = true;
  };

  gtk = {
    enable = true;

    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
    colorScheme = "dark";

    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme.override { color = "bluegrey"; };
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "kvantum";
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [
        "BitstromWera Nerd Font Propo"
        "Noto Color Emoji"
      ];
      monospace = [
        "BitstromWera Nerd Font Mono"
      ];
      sansSerif = [
        "BitstromWera Nerd Font Propo"
      ];
      serif = [
        "BitstromWera Nerd Font Propo"
      ];
    };
  };
}
