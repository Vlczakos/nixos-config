{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    killall
    git
    usbutils
    sshfs
  ];

  programs.direnv.enable = true;
  programs.tmux.enable = true;
}
