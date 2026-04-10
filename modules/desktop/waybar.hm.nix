{ pkgs, lib, config, ... }:
let
  colors = config.lib.stylix.colors;
in
{
  options.custom.desktop.waybar = {
    enable = lib.mkEnableOption "Waybar";
  };

  config = lib.mkIf config.custom.desktop.waybar.enable {
    stylix.targets.waybar.enable = false;

    services.playerctld.enable = true;

    programs.waybar = {
      enable = true;

      settings = {
        topbar = {
          layer = "top";
          position = "right";

          modules-left = [ "clock" ];
          modules-center = [ "hyprland/workspaces" ];
          modules-right = [
            "tray"
            "pulseaudio"
            "backlight"
            "battery"
          ];

          tray = {
            icon-size = 19;
            spacing = 8;
          };

          clock = {
            # format = "{:%H\n%M}";
            format = "{:%H\n%M\n―\n%d\n%m}";
            tooltip = false;
          };

          pulseaudio = {
            format = "{icon}";
            format-muted = "";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
            ];
            tooltip-format = "{desc} - {volume}%";
            on-click = "${lib.getExe pkgs.pavucontrol}";
            on-scroll-up = "${lib.getExe pkgs.pamixer} --allow-boost -i 1";
            on-scroll-down = "${lib.getExe pkgs.pamixer} --allow-boost -d 1";
            on-click-middle = "${lib.getExe pkgs.pamixer} -t";
          };

          backlight = {
            device = "intel_backlight";
            format = "{icon}";
            tooltip-format = "{percent}%";
            format-icons = [
              "󰃞"
              "󰃟"
              "󰃠"
            ];
            on-scroll-up = "${lib.getExe pkgs.brightnessctl} set +5%";
            on-scroll-down = "${lib.getExe pkgs.brightnessctl} set 5%-";
            on-click-middle = "${lib.getExe pkgs.brightnessctl} set 0";
          };

          battery = {
            interval = 1;
            tooltip-format = "{capacity}%";
            format = "{icon}";
            format-charging = "󰂄";
            format-icons = [
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
          font-family: "${config.stylix.fonts.monospace.name}";
          font-size: ${toString config.stylix.fonts.sizes.desktop}px;
          font-weight: bold;
          min-height: 0;
          border: none;
          box-shadow: none;
        }

        @define-color fill-bg #${colors.base01};
        @define-color main-bg #${colors.base00};
        @define-color main-fg #${colors.base05};
        @define-color active-bg #${colors.base02};
        @define-color active-fg #${colors.base05};
        @define-color hover-bg #${colors.base03};
        @define-color hover-fg #${colors.base05};
        @define-color main-border #${colors.base03};
        @define-color hover-border #${colors.base0C};
        @define-color active-border #${colors.base0D};

        window#waybar {
          background: @fill-bg;
          border-left: 2px solid @main-border;
        }

        #workspaces,
        #workspaces button,
        #clock,
        #tray,
        #battery,
        #backlight,
        #pulseaudio {
          background: @main-bg;
          color: @main-fg;
        }

        #workspaces,
        #clock,
        #tray,
        #battery,
        #backlight,
        #pulseaudio {
          margin-left: 4px;
        }

        #workspaces button {
          padding: 2px 3px;
          margin: 2px;
          margin-left: 2px;
          margin-right: 0px;
          border-radius: 0px;
          border-top-left-radius: 5px;
          border-bottom-left-radius: 5px;
          border-right: 2px solid @main-bg;
          transition: all 0.2s ease-in-out;
        }

        #workspaces button.active {
          background: @active-bg;
          color: @active-fg;
          border-right: 2px solid @active-border;
        }

        #workspaces button:hover {
          background: @hover-bg;
          color: @hover-fg;
          border-right: 2px solid @hover-border;
        }

        tooltip, 
        #tray menu {
          background: @main-bg;
          color: @main-fg;
          border: 1px solid @active-border;
        }

        #tray,
        #pulseaudio,
        #backlight,
        #battery {
          padding: 3px;
        }

        .modules-left > widget:first-child > *,
        .modules-center > widget:first-child > *,
        .modules-right > widget:first-child > * {
          border-top-left-radius: 5px;
          padding-top: 6px;
        }

        .modules-left > widget:last-child > *,
        .modules-center > widget:last-child > *,
        .modules-right > widget:last-child > * {
          border-bottom-left-radius: 5px;
          padding-bottom: 6px;
        }

        .modules-left > widget:first-child > * {
          margin-top: 80px;
        }


        .modules-center > widget:last-child > * {
          margin-bottom: 200px;
        }

        .modules-right > widget:last-child > * {
          margin-bottom: 60px;
        }

        #pulseaudio, 
        #backlight {
          font-size: 20px;
        }

        #battery {
          font-size: 14px;
        }
      '';
    };
  };
}
