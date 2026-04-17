{ lib, config, ... }:
let
  sync_pcs = [
    "krakatice"
    "tucnak"
    "ustrice"
    "nemo"
  ];

  sync_phone = [
    "nothing2A"
  ];
in
{
  options.custom.services.syncthing = {
    enable = lib.mkEnableOption "Syncthing";
  };

  config = lib.mkIf config.custom.services.syncthing.enable {
    networking.firewall.interfaces."wg0" = {
      allowedTCPPorts = [ 22000 ];
      allowedUDPPorts = [ 22000 ];
    };

    home-manager.sharedModules = [ ./home.nix ];

    services.syncthing = {
      enable = true;

      user = "vlczak";
      dataDir = "/home/vlczak/.local/share/syncthing"; 
      configDir = "/home/vlczak/.config/syncthing";

      settings = {
        folders = {
          "/nixos-config" = {
            id = "vlczak-nixos-config";
            devices = sync_pcs;
          };
          "~/Documents" = {
            id = "vlczak-documents";
            devices = sync_pcs;
          };
          "~/Pictures" = {
            id = "vlczak-pictures";
            devices = sync_pcs;
          };
          "~/Programming" = {
            id = "vlczak-programming";
            devices = sync_pcs;
          };
          "~/Pictures/Photos" = {
            id = "vlczak-photos";
            devices = sync_pcs ++ sync_phone;
          };
        };

        devices = {
          "nemo" = {
            id = "4GR6R6D-K4LYPYF-L3COZKB-2EYS7DU-AW3ZVEY-FLFOMR2-N7K463F-22M5DQ5";
            addresses = [
              "quic://10.20.30.70:22000"
              "tcp://10.20.30.70:22000"
            ];
          };
          "ustrice" = {
            id = "BY6QHBI-IYP6A46-QDPGCVY-5DAFHGT-NX4VYFI-KJW6Z26-VDJUCSN-IBPRHAR";
            addresses = [
              "quic://10.20.30.80:22000"
              "tcp://10.20.30.80:22000"
            ];
          };
          "krakatice" = {
            id = "JA5HIV3-I2XGPKX-UREJNH6-37GJHNU-XZ2MK76-7UW6B5A-5WQSGMA-R3SIPQK";
            addresses = [
              "quic://10.20.30.90:22000"
              "tcp://10.20.30.90:22000"
            ];
          };
          "tucnak" = {
            id = "XO5URIU-ZHU3D4S-RTQRDSK-ZL7VKMR-QMIPZNU-AYAUN5I-K7FZCKB-U45Q7QJ";
            addresses = [
              "quic://10.20.30.100:22000"
              "tcp://10.20.30.100:22000"
            ];
          };
          "nothing2A" = {
            id = "FNEJVTE-BCON45I-6MXQGJU-EWORGOB-NKZWWZJ-WLJUTWM-F3KGXJZ-SJGGHQO";
            addresses = [
              "quic://10.20.30.101:22000"
              "tcp://10.20.30.101:22000"
            ];
          };
        };

        options = {
          relaysEnabled = false;
          globalAnnounceEnabled = false;
          localAnnounceEnabled = false;
          natEnabled = false;
          urAccepted = -1;
          # guiEnabled = false;
        };
      };
    };
  };
}
