{ pkgs, ... }:

{
  hardware.saleae-logic.enable = true;

  environment.systemPackages = with pkgs; [
    saleae-logic-2
  ];
}