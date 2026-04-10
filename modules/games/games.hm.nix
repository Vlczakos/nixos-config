{
  pkgs,
  lib,
  osConfig,
  ...
}:
{
  config = lib.mkIf osConfig.custom.games.enable {
    home.packages = with pkgs; [
      (prismlauncher.override (prev: {
        jdks = [ pkgs.temurin-bin-25 ];
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
  };
}
