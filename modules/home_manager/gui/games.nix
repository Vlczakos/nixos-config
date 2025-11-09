{ pkgs, ... }:
{
  home.packages = with pkgs; [
    prismlauncher
  ];

  programs.mangohud = {
    enable = true;

    settings = {
      cpu_stats = true;
      cpu_temp = true;

      gpu_stats = true;
      gpu_temp = true;

      fps = true;
      frametime = true;

      toggle_hud = "Shift_R";
    };
  };
}