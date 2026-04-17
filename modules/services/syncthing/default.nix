{ lib, config, ... }:
{
  options.custom.services.syncthing = {
    enable = lib.mkEnableOption "Syncthing";
  };

  config = lib.mkIf config.custom.services.syncthing.enable {
    networking.firewall.interfaces."wg0" = {
      allowedTCPPorts = [ 22000 ];
      allowedUDPPorts = [ 22000 ];
    };

    home-manager.sharedModules = [ ./home.nix ];
  };
}
