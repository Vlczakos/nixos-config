{ ... }:
{
  imports = [
    ./core.os.nix
    ./gui.os.nix
  ];

  home-manager.sharedModules = [
    ./home.nix
  ];
}
