{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.custom.services.sunshine = {
    enable = lib.mkEnableOption "Sunshine";
  };

  config = lib.mkIf config.custom.services.sunshine.enable {
    services.sunshine = {
      enable = true;
      openFirewall = true;
      capSysAdmin = true;

      # applications = {
      #   apps = [
      #     {
      #       name = "1440p Desktop";
      #       prep-cmd = [
      #         {
      #           do = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.DP-4.mode.2560x1440@144";
      #           undo = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.DP-4.mode.3440x1440@144";
      #         }
      #       ];
      #       exclude-global-prep-cmd = "false";
      #       auto-detach = "true";
      #     }
      #   ];
      # }
      # ;

      package = pkgs.sunshine.override { cudaSupport = true; };
    };
  };
}
