{ pkgs, ... }:
{
  home.packages = with pkgs; [
    #nerd-fonts.blex-mono
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
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme.override { color = "bluegrey"; };
    };
  };

  qt = {
    enable = true;
    platformTheme = {
      name = "gtk3";
    };
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts.emoji = [
      "BitstromWera Nerd Font Propo"
      "Noto Color Emoji"
    ];
    defaultFonts.monospace = [
      "BitstromWera Nerd Font Mono"
    ];
    defaultFonts.sansSerif = [
      "BitstromWera Nerd Font Propo"
    ];
    defaultFonts.serif = [
      "BitstromWera Nerd Font Propo"
    ];
  };
}
