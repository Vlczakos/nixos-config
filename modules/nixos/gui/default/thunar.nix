{ pkgs, ... }:
{
  programs.thunar = {
    enable = true;

    plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
  };

  programs.file-roller.enable = true;
}