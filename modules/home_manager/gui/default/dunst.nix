{ ... }:
{
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
        enable_posix_regex = true;
        gap_size = 1;
      };

      urgency_low = {
        timeout = 5;
      };

      urgency_normal = {
        timeout = 5;
      };

      urgency_critical = {
        timeout = 60;
      };
    };
  };
}
