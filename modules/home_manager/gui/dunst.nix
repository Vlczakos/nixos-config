{ lib, nixos-config, ... }:
lib.mkIf nixos-config.gui.enable {
  services.dunst = {
    enable = true;

    settings = {
      global = {
        follow = "mouse";
        width = "(0, 300)";
        height = "(0, 300)";
        offset = "(5,5)";
        # origin = "bottom-right";
        corner_radius = 5;
        frame_width = 1;
        show_age_threshold = -1;
        font = "Monospace 12";
        enable_posix_regex = true;
        frame_color = "#cdd6f4a0";
        foreground = "#cdd6f4";
        gap_size = 1;
      };

      urgency_low = {
        background = "#11111ba0";
        timeout = 5;
      };

      urgency_normal = {
        background = "#11111ba0";
        timeout = 5;
      };

      urgency_critical = {
        background = "#ff000090";
        timeout = 60;
      };
    };
  };
}
