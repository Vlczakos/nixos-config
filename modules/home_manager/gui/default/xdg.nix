{ pkgs, lib, ... }:
{
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications =
        let
          imageSubtypes = [
            "jpeg"
            "jpg"
            "png"
            "gif"
            "webp"
            "bmp"
            "tiff"
            "tif"
            "svg"
            "ico"
            "heic"
            "heif"
            "avif"
            "jxl"
            "raw"
          ];
          imageMimes = map (sub: "image/${sub}") imageSubtypes;
          imageAssoc = lib.listToAttrs (
            map (mime: {
              name = mime;
              value = [ "qimgv.desktop" ];
            }) imageMimes
          );
        in
        {
          "inode/directory" = [ "thunar.desktop" ];
          "application/zip" = [ "org.gnome.FileRoller.desktop" ];
          "x-scheme-handler/terminal" = [ "kitty-open.desktop" ];
          "text/plain" = [ "codium.desktop" ];
        }
        // imageAssoc;
    };
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
      ];
      configPackages = [ pkgs.hyprland ];
    };
    configFile."mimeapps.list".force = true;
  };
}
