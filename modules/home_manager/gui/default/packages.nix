{ pkgs, ... }:

{
  home.packages = with pkgs; [
    brave
    widevine-cdm
    vesktop
    kdePackages.okular
    xournalpp
    vlc
    onlyoffice-desktopeditors
    libreoffice-fresh
    gimp
    qimgv
    (bottles.override { removeWarningPopup = true; })
    moonlight-qt
    
    (betaflight-configurator.override (
      prev: {
        nwjs = prev.nwjs.overrideAttrs {
          version = "0.84.0";
          src = prev.fetchurl {
            url = "https://dl.nwjs.io/v0.84.0/nwjs-v0.84.0-linux-x64.tar.gz";
            hash = "sha256-VIygMzCPTKzLr47bG1DYy/zj0OxsjGcms0G1BkI/TEI=";
          };
        };
      }
    ))

    xdg-utils
    networkmanagerapplet
    pavucontrol
    hyprpolkitagent
    dconf
  ];

  services.playerctld.enable = true;
}
