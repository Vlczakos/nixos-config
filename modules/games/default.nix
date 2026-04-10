{ lib, ... }:
{
  options.custom.games = {
    enable = lib.mkEnableOption "Games";
  };

  imports = [
    ./games.os.nix
  ];

  config = {
    home-manager.sharedModules = [
      ./games.hm.nix
    ];
  };
}
