{ pkgs, ... }:
let
  thunar_unwrapped = pkgs.thunar-unwrapped.overrideAttrs (o: {
    configureFlags = (o.configureFlags or [ ]) ++ [ "--disable-wallpaper-plugin" ];
  });

  thunar_package = pkgs.thunar.override {
    thunar-unwrapped = thunar_unwrapped;
    thunarPlugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
in
{
  environment.systemPackages = [
    pkgs.file-roller
    thunar_package
  ];

  services.dbus.packages = [
    thunar_package
  ];

  systemd.packages = [
    thunar_package
  ];

  programs.xfconf.enable = true;
}
