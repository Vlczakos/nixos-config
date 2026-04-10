{
  config,
  lib,
  pkgs,
  ...
}:
let
  scripts = import ./scripts.nix { inherit lib pkgs; };
  settings = import ./settings.nix { inherit pkgs config; };
  binds = import ./binds.nix {
    inherit lib pkgs;
    scripts = scripts;
  };
  headless_conf = pkgs.writeText "headless_wrapper.conf" ''
    source = ~/.config/hypr/hyprland.conf
    monitor = , disable
    exec-once = hyprctl output create headless
    monitor = HEADLESS-2, 1920x1080@60, 0x0, 1
  '';
in
{
  options.custom.desktop.hyprland = {
    enable = lib.mkEnableOption "Hyprland";
  };

  config = lib.mkIf config.custom.desktop.hyprland.enable {
    home.packages = [
      (pkgs.writeShellScriptBin "HeadlessHyprland" ''
        exec Hyprland
      '')
      pkgs.hyprpolkitagent
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      systemd = {
        enableXdgAutostart = true;
        variables = [ "--all" ];
      };

      settings = settings // binds.settings;

      extraConfig = binds.extraConfig;
    };

    services.hyprpaper = {
      enable = true;
      settings = {
        splash = false;
        ipc = false;
      };
    };

    home.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
