{ pkgs, config }:
{
  env = [
    "XDG_SESSION_TYPE,wayland"
    "QT_QPA_PLATFORM,wayland"
    "WLR_DRM_NO_ATOMIC,1"
  ];

  monitor = [ ",preferred,auto-up,1" ];

  exec = [
    "hyprctl setcursor ${config.gtk.cursorTheme.name} ${toString config.gtk.cursorTheme.size}"
  ];

  exec-once = [
    "vesktop --start-minimized --enable-features=WebRTCPipeWireCapturer --ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --disable-gpu"
    "waybar"
    "dunst"
    "blueman-applet"
    "${pkgs.networkmanagerapplet}/bin/nm-applet"
    "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    "systemctl --user start hyprpolkitagent"
  ];

  input = {
    kb_layout = "us,cz";
    kb_variant = ",qwerty";
    follow_mouse = 1;
    numlock_by_default = true;
    touchpad.natural_scroll = false;
    sensitivity = 0.0;
  };

  cursor.no_hardware_cursors = true;

  general = {
    gaps_in = 2;
    gaps_out = 5;
    border_size = 1;
    layout = "dwindle";
    allow_tearing = true;
  };

  decoration = {
    rounding = 5;
    "blur:enabled" = false;
  };

  animations = {
    enabled = true;
    bezier = [
      "snap, 0.2, 1, 0.3, 1"
      "quick, 0.15, 0, 0.1, 1"
    ];
    animation = [
      "windows, 1, 2, snap, slide"
      "windowsOut, 1, 3, quick, popin 80%"
      "windowsMove, 1, 2, snap, slide"
      "border, 1, 3, default"
      "fade, 1, 3, default"
      "workspaces, 1, 4, snap, slide"
      "specialWorkspace, 1, 4, snap, fade"
      "layers, 1, 6, snap, slidefade"
      "layersOut, 1, 8, snap, slidefade"
    ];
  };

  layerrule = [
    "animation fade, match:namespace selection"
    "animation fade, match:namespace hyprpicker"
  ];

  dwindle = {
    pseudotile = true;
    preserve_split = true;
  };

  device = [
    {
      name = "glorious-model-o-wireless";
      sensitivity = -1.0;
    }
    {
      name = "glorious-model-o-wireless-1";
      sensitivity = -1.0;
    }
    {
      name = "mouse-passthrough";
      sensitivity = -1.0;
    }
  ];

  misc = {
    disable_hyprland_logo = true;
    disable_splash_rendering = true;
    disable_watchdog_warning = true;
    force_default_wallpaper = 0;
    vfr = true;
  };
}
