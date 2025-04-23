{ lib, ... }:
{ 
  options = {
    gui.enable = lib.mkEnableOption "GUI";
  };

  imports = [
    ./steam.nix
    ./thunar.nix
  ];
}
