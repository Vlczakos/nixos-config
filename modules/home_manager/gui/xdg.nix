{ lib, nixos-config, pkgs, ... }:
lib.mkIf nixos-config.gui.enable {
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = [ "thunar.desktop" ];
        "application/zip" = [ "org.gnome.FileRoller.desktop" ];
        "x-scheme-handler/terminal" = [ "kitty-open.desktop" ];
      };
    };
    portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-hyprland];
      configPackages = [pkgs.hyprland];
    };
  };
}