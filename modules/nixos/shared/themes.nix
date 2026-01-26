{
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    polarity = "dark";

    base16Scheme = {
      # Primary
      base00 = "#000000"; # Background
      base01 = "#202223";
      base02 = "#34393b"; # Selections
      base03 = "#575d60"; # Comments
      base04 = "#93999d";
      base05 = "#e0e0e0"; # Text
      base06 = "#f0f0f0";
      base07 = "#ffffff"; # White

      # Accents
      base08 = "#ff0f0f";
      base09 = "#ff7a2d";
      base0A = "#ffff17";
      base0B = "#26ff00";
      base0C = "#00ffff";
      base0D = "#40b4ff";
      base0E = "#ff5ef4";
      base0F = "#ff627f";
    };

    fonts = {
      serif = {
        package = pkgs.nerd-fonts.bitstream-vera-sans-mono;
        name = "BitstromWera Nerd Font Propo";
      };

      sansSerif = {
        package = pkgs.nerd-fonts.bitstream-vera-sans-mono;
        name = "BitstromWera Nerd Font Propo";
      };

      monospace = {
        package = pkgs.nerd-fonts.bitstream-vera-sans-mono;
        name = "BitstromWera Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 10; # Prohlížeče, GTK/Qt okna, nastavení
        terminal = 10; # Alacritty, Kitty, Foot
        desktop = 14; # Waybar, lišty, panely
        popups = 12; # Notifikace, kontextová menu
      };
    };

    autoEnable = false;

    targets = {
      console.enable = true;
    };
  };
}
