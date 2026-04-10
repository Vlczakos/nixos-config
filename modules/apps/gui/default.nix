{ ... }:
{
  imports = [
    ./thunar.os.nix
  ];

  home-manager.sharedModules = [
    ./bundle.hm.nix
    ./vscode.hm.nix
  ];
}