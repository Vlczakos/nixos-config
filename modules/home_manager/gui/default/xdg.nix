{ pkgs, ... }:
{
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = [ "thunar.desktop" ];
        "application/zip" = [ "org.gnome.FileRoller.desktop" ];
        "x-scheme-handler/terminal" = [ "kitty-open.desktop" ];
        "text/plain" = [ "codium.desktop" ];
      };
    };
    portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk];
      configPackages = [pkgs.hyprland];
    };
    configFile."mimeapps.list".force = true;
  };
}