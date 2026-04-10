{ ... }:
{
  imports = [
    ./bundle.os.nix
  ];

  home-manager.sharedModules = [
    ./btop.hm.nix
    ./bundle.hm.nix
    ./fastfetch.hm.nix
    ./fish.hm.nix
    ./rbw.hm.nix
  ];
}