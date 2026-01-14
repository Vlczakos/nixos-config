{ pkgs, ... }:
{
  stylix.autoEnable = true;

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 19;

    x11.enable = true;
    gtk.enable = true;
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme.override { color = "bluegrey"; };
    };
  };

  qt = {
    enable = true;
  };
}
