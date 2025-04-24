{ ... }:
{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
      };

      background = [ 
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          size = "300, 50";
          valign = "bottom";
          position = "0, 80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(cdd6f4)";
          inner_color = "rgb(11111b)";
          shadow_color = "rgb(cdd6f4)";
          placeholder_text = "Password...";
          fail_text = "$FAIL";
          shadow_passes = 2;
          outline_thickness	= 0;
          swap_font_color = true;
        }
      ];

    };
  };
}
