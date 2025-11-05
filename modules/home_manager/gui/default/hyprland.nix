{
  config,
  pkgs,
  lib,
  ...
}:
let
  blue_light_filter_shader = builtins.toFile "blue_light_filter.frag" ''
    // from https://github.com/hyprwm/Hyprland/issues/1140#issuecomment-1335128437

    #version 300 es
    precision highp float;

    in vec2 v_texcoord;
    uniform sampler2D tex;
    out vec4 fragColor;

    const float temperature = 2600.0;
    const float temperatureStrength = 1.0;

    #define WithQuickAndDirtyLuminancePreservation
    const float LuminancePreservationFactor = 1.0;

    // function from https://www.shadertoy.com/view/4sc3D7
    // valid from 1000 to 40000 K (and additionally 0 for pure full white)
    vec3 colorTemperatureToRGB(const in float temperature) {
        // values from: http://blenderartists.org/forum/showthread.php?270332-OSL-Goodness&p=2268693&viewfull=1#post2268693
        mat3 m = (temperature <= 6500.0)
            ? mat3(vec3(0.0, -2902.1955373783176, -8257.7997278925690),
                  vec3(0.0, 1669.5803561666639, 2575.2827530017594),
                  vec3(1.0, 1.3302673723350029, 1.8993753891711275))
            : mat3(vec3(1745.0425298314172, 1216.6168361476490, -8257.7997278925690),
                  vec3(-2666.3474220535695, -2173.1012343082230, 2575.2827530017594),
                  vec3(0.55995389139931482, 0.70381203140554553, 1.8993753891711275));

        return mix(
            clamp(m[0] / (vec3(clamp(temperature, 1000.0, 40000.0)) + m[1]) + m[2], 0.0, 1.0),
            vec3(1.0),
            smoothstep(1000.0, 0.0, temperature)
        );
    }

    void main() {
        vec4 pixColor = texture(tex, v_texcoord);
        vec3 color = pixColor.rgb;

    #ifdef WithQuickAndDirtyLuminancePreservation
        float lum = dot(color, vec3(0.2126, 0.7152, 0.0722));
        color *= mix(1.0, lum / max(lum, 1e-5), LuminancePreservationFactor);
    #endif

        color = mix(color, color * colorTemperatureToRGB(temperature), temperatureStrength);

        fragColor = vec4(color, pixColor.a);
    }
  '';
  hyprland_screen_shader = lib.getExe (
    pkgs.writeShellScriptBin "hyprland_screen_shader" ''
      turn_on() {
        if [ "$2" == "on" ]; then 
          hyprctl keyword debug:damage_tracking off
        fi

        hyprctl keyword decoration:screen_shader $1
      }

      turn_off() {
        hyprctl keyword debug:damage_tracking on
        hyprctl keyword decoration:screen_shader ""
      }

      case $1 in
        toggle)
          value="$(hyprctl getoption decoration:screen_shader | grep str)"

          if [ "$value" == "str: $2" ]; then 
            turn_off
          else
            turn_on $2 $3
          fi

          ;;
        on)
          turn_on $2 $3
          ;;
        off)
          turn_off
          ;;
      esac
    ''
  );
  volume_script = lib.getExe (
    pkgs.writeShellScriptBin "volume_script" ''
      case $1 in
        t)
          pamixer -t
          ;;
        i)
          pamixer --allow-boost -i 1
          ;;
        d)
          pamixer --allow-boost -d 1
          ;;
      esac

      volume=$(pamixer --get-volume-human)
      #device=$(pamixer --get-default-sink | awk 'NR == 2' | sed -n 's/.*"\(.*\)"/\1/p')

      dunstify -h string:x-dunst-stack-tag:volume -t 1000 $volume
    ''
  );
  brightness_script = lib.getExe (
    pkgs.writeShellScriptBin "brightness_script" ''
      case $1 in
        i)
          brightnessctl set +5%
          ;;
        d)
          brightnessctl set 5%-
          ;;
      esac

      curr_brightness=$(brightnessctl get)
      max_brightness=$(brightnessctl max)
      brightness=$((curr_brightness * 100 / max_brightness))

      dunstify -h string:x-dunst-stack-tag:brightness -t 1000 $brightness%
    ''
  );
  keyboard_switch_script = lib.getExe (
    pkgs.writeShellScriptBin "keyboard_toggle_script" ''
      keyboards=$(hyprctl devices | grep -A7 "Keyboard at" | grep -B6 "main: yes" | awk 'NR % 8 == 1' | awk '{print $1}')

      for kbd in $keyboards; do
          hyprctl switchxkblayout "$kbd" next
      done

      active=$(hyprctl devices | grep -A3 "$keyboards" | grep "active keymap:" | awk '{$1=""; $2=""; sub(/^  */, ""); print}')

      dunstify -h string:x-dunst-stack-tag:keyboard_layout -t 1000 "$active"
    ''
  );
in
{
  wayland.windowManager.hyprland = {
    enable = true;

    systemd = {
      enableXdgAutostart = true;
      variables = [ "--all" ];
    };

    settings = {
      env = [
        "XDG_SESSION_TYPE,wayland"
        "QT_QPA_PLATFORM,wayland"
        "WLR_DRM_NO_ATOMIC,1"
      ];

      monitor = [
        ",preferred,auto-up,1"
      ];

      exec = [
        "hyprctl setcursor ${config.gtk.cursorTheme.name} ${builtins.toString config.gtk.cursorTheme.size}"
      ];

      exec-once = [
        "vesktop --start-minimized --enable-features=WebRTCPipeWireCapturer --ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --disable-gpu"

        "waybar"
        "swww-daemon"
        "dunst"
        "blueman-applet"
        "nm-applet"
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
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        allow_tearing = true;
      };

      decoration = {
        rounding = 5;
        "blur:enabled" = false;
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

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

      gesture = [
        "3, horizontal, workspace"
      ];

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        vfr = true;
      };

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, T, exec, kitty"
        "$mainMod, E, exec, thunar"
        "$mainMod, B, exec, brave"
        "$mainMod, C, exec, codium"
        "$mainMod, P, exec, kitty ${lib.getExe pkgs.python3}"
        "$mainMod, O, exec, okular"
        "$mainMod, X, exec, xournalpp"

        ", Print, exec, grimblast copy area --freeze"
        "CONTROL, Escape, exec, kitty btop"
        "CONTROL+SHIFT, Escape, exec, killall .waybar-wrapped || waybar"
        "$mainMod, Q, killactive"
        "$mainMod, M, fullscreen"
        "$mainMod, F, togglefloating"
        "$mainMod, S, togglesplit"
        "$mainMod, Escape, exit"
        "$mainMod, G, togglegroup"
        "$mainMod, L, exec, hyprlock"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod, A, togglespecialworkspace"
        "$mainMod SHIFT, A, movetoworkspacesilent, special"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindl = [
        ", XF86AudioMute, exec, ${volume_script} t"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"

        "$mainMod, K, exec, hyprctl dispatch dpms off"
        "$mainMod SHIFT, K, exec, hyprctl dispatch dpms on"

        ",switch:on:Lid Switch,exec, hyprctl dispatch dpms off && hyprlock"
        ",switch:off:Lid Switch,exec, hyprctl dispatch dpms on"

        "$mainMod, N, exec, ${hyprland_screen_shader} toggle ${blue_light_filter_shader}"

        "$mainMod, Space, exec, ${keyboard_switch_script}"
      ];

      bindel = [
        ", XF86MonBrightnessUp, exec, ${brightness_script} i"
        ", XF86MonBrightnessDown, exec, ${brightness_script} d"
        ", XF86AudioLowerVolume, exec, ${volume_script} d"
        ", XF86AudioRaiseVolume, exec, ${volume_script} i"
      ];
    };

 
    extraConfig = ''
      bind = $mainMod, delete, exec, hyprctl dispatch dpms off
      bind = $mainMod, delete, submap, cheat

      submap = cheat
      bind =  , mouse:272, exec, hyprctl dispatch dpms on
      bindr = , mouse:272, exec, hyprctl dispatch dpms off

      bind = $mainMod, delete, exec, hyprctl dispatch dpms on
      bind = $mainMod, delete, submap, reset
      bind = , catchall, exec, 
      submap = reset
    '';
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
