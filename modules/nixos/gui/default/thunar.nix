{ pkgs, ... }:
let
  thunarUnwrapped = pkgs.xfce.thunar.overrideAttrs (o: {
    configureFlags = (o.configureFlags or []) ++ [ "--disable-wallpaper-plugin" ];
  });

  thunarWithPlugins = pkgs.callPackage
    "${builtins.dirOf pkgs.xfce.thunar.meta.position}/wrapper.nix"
    {
      inherit (pkgs) makeWrapper symlinkJoin lib;
      thunarPlugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
      thunar-unwrapped = thunarUnwrapped;
    };
in
{
  environment.systemPackages = [
    thunarWithPlugins
  ];

  services.dbus.packages = [
    thunarWithPlugins
  ];

  systemd.packages = [
    thunarWithPlugins
  ];

  programs.xfconf.enable = true;
  programs.file-roller.enable = true;
}