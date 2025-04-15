{ ... }:
{
  programs.nh = {
    enable = true;
    flake = "/nixos-config";
  };
}