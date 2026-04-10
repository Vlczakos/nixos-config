{ ... }:
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
  home.file = {
    "Programming/.stignore" = {
      force = true;
      text = ''
        target
        .direnv
      '';
    };
    "Pictures/.stignore" = {
      force = true;
      text = ''
        /Photos
      '';
    };
  };

  services.syncthing = {
    enable = true;

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
          id = "FI3A477-2ZEKHQY-DRXOXPC-VTEPT22-UYJOA66-7IFPOTM-US7JWOI-V46VTQM";
          addresses = [
            "quic://10.20.30.70:22000"
            "tcp://10.20.30.70:22000"
          ];
        };
        "ustrice" = {
          id = "X7N5G26-ES7BGE7-ASXEHHJ-DHUPBY7-CNLPHXU-RDEQKNS-2TIGU42-EYU3EAY";
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
          id = "I3SB3GU-JT56N2A-D376G5E-2AJ3XKK-W5LRERJ-AR7SUGA-P2RSZ5Y-WOFYWAQ";
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
        # guiEnabled = false;
      };
    };
  };
}
