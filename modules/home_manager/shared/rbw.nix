{ pkgs, ... }:
{
  programs.rbw = {
    enable = true;

    settings = {
      email = "vlcek.david@outlook.cz";
      pinentry = pkgs.pinentry-tty;
    };
  };
}