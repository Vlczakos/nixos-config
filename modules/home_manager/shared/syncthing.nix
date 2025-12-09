{ ... }:
{
  services.syncthing = {
    enable = true;
    tray.enable = true;

    settings = {
      folders = {
        "~/Documents" = {
          id = "vlczak-documents";
          devices = [ "krakatice" "ustrice" "tucnak" ];
        };
        "~/Pictures" = {
          id = "vlczak-pictures";
          devices = [ "krakatice" "ustrice" "tucnak" "nothing2A" ];
        };
        "~/Programming" = {
          id = "vlczak-programming";
          devices = [ "krakatice" "ustrice" "tucnak" ];
        };
      };

      devices = {
        "krakatice" = {
          id = "JA5HIV3-I2XGPKX-UREJNH6-37GJHNU-XZ2MK76-7UW6B5A-5WQSGMA-R3SIPQK";
          addresses = [ "tcp://10.20.30.90:22000" ];
        };
        "tucnak" = {
          id = "I3SB3GU-JT56N2A-D376G5E-2AJ3XKK-W5LRERJ-AR7SUGA-P2RSZ5Y-WOFYWAQ";
        };
        "ustrice" = {
          id = "PLACEHOLDER";
        };
        "nothing2A" = {
          id = "FNEJVTE-BCON45I-6MXQGJU-EWORGOB-NKZWWZJ-WLJUTWM-F3KGXJZ-SJGGHQO";
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
