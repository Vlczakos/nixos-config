{ pkgs, ... }:
{
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  programs.command-not-found.enable = false;
}
