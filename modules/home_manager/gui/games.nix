{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (prismlauncher.override (prev: {
      jdk21 = pkgs.temurin-bin-25;
      jdk17 = pkgs.temurin-bin-25;
    }))
  ];

  programs.mangohud = {
    enable = true;

    settings = {
      core_load = true;
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
