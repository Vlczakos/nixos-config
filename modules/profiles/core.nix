{ lib, config, ... }:
{
  options.custom.profiles.core = lib.mkEnableOption "Core profile";

  config = lib.mkIf config.custom.profiles.core {
    custom = {
      apps.cli = {
        bundle.enable = true;
      };
    };

    home-manager.sharedModules = [
      {
        custom.apps.cli = {
          btop.enable = true;
          bundle.enable = true;
          fastfetch.enable = true;
          fish.enable = true;
          rbw.enable = true;
        };
      }
    ];
  };
}
