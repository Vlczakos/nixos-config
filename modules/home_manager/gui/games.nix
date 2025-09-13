{ pkgs, ... }:
{
  home.packages = with pkgs; [
    prismlauncher
  ];

  programs.mangohud = {
    enable = true;
  };
}