{ lib, nixos-config, ... }:
lib.mkIf nixos-config.gui.enable {
  programs.waybar = {
    enable = true;

    settings = {
      topbar = {
        layer = "bottom";
        position = "top";
        # output = ["eDP-1"];
        margin-top = 3;

        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "tray"
          # "bluetooth"format_source
          "pulseaudio"
          "backlight"
          # "custom/power"
          "battery"
        ];


        "tray" = {
          icon-size = 19;
          spacing = 5;
          rotate = 0;
        };

        "clock" = {
          "format" = "{:%H:%M}";
          "format-alt" = "{:%d. %m.  %H:%M}";
          tooltip = false;
        };

        "pulseaudio" = {
          "format" = "   ";
          "format-muted" = "   ";
          "tooltip-format" = "{desc} - {volume}%";
          "on-click" = "pavucontrol";
          "on-scroll-up" = "pamixer --allow-boost -i 1";
          "on-scroll-down" = "pamixer --allow-boost -d 1";
          "on-click-middle" = "pamixer -t";
        };

        "backlight" = {
          "device" = "intel_backlight";
          "format" = "{icon} ";
          "tooltip-format" = "{percent}%";
          "format-icons" = [
            "󰃞"
            "󰃟"
            "󰃠"
          ];
          "on-scroll-up" = "brightnessctl set +5%";
          "on-scroll-down" = "brightnessctl set 5%-";
          "on-click-middle" = "brightnessctl set 0";
        };

        "battery" = {
          "interval" = 1;
          "format" = " {icon}";
          "format-charging" = " 󰂄";
          "tooltip-format" = "{capacity}%";
          "format-icons" = [
            "󰂃"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
        };
      };
    };

    style = ''
      * {
        font-weight: 600;
        font-size: 15px;
        min-height: 0;
      }

      @define-color main-bg #11111b;
      @define-color main-fg #cdd6f4;

      @define-color wb-act-bg #a6adc8;
      @define-color wb-act-fg #313244;

      @define-color wb-hvr-bg #f5c2e7;
      @define-color wb-hvr-fg #313244;

      window#waybar {
        background: rgba(0, 0, 0, 0);
      }

      #workspaces,
      #clock,
      #tray menu,
      #tray,
      #pulseaudio,
      #backlight,
      #battery,
      tooltip {
        background: @main-bg;
        color: @main-fg;
      }

      #tray menu,
      tooltip {
        border-radius: 7px;
        border-width: 0px;
      }

      #tray menu {
        padding-top: 15px;
      }

      #workspaces button {
        padding: 0px;
        border-radius: 9px;
        margin-top: 3px;
        margin-bottom: 3px;
        margin-left: 0px;
        margin-right: 0px;
        padding-left: 5px;
        padding-right: 5px;
        color: @main-fg;

        transition: all 0.2s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #workspaces button.active {
        background: @wb-act-bg;
        color: @wb-act-fg;

        transition: all 0.2s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #workspaces button:hover {
        background: @wb-hvr-bg;
        color: @wb-hvr-fg;

        transition: all 0.15s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #clock,
      #workspaces,
      #tray {
        border-bottom-left-radius: 10px;
        border-top-left-radius: 10px;
        margin-left: 5px;
      }
      #clock,
      #workspaces,
      #battery {
        border-bottom-right-radius: 10px;
        border-top-right-radius: 10px;
        margin-right: 5px;
      }

      #clock,
      #tray {
        padding-left: 10px;
      }

      #clock,
      #battery {
        padding-right: 10px;
      }

      #workspaces {
        padding-left: 7px;
        padding-right: 7px;
      }
    '';
  };
}
