{ pkgs, lib, config, ... }:
lib.mkIf config.gui.enable {
  programs.thunar = {
    enable = true;

    plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
  };

  programs.file-roller.enable = true;
}