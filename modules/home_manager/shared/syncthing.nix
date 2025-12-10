{ ... }:
{
  home.file."Programming/.stignore" = {
    force = true;
    text = ''
      target
      .direnv
    '';
  };

  services.syncthing = {
    enable = true;

    settings = {
      folders = {
        "~/Documents" = {
          id = "vlczak-documents";
          devices = [
            "krakatice"
            "tucnak"
            "ustrice"
          ];
        };
        "~/Pictures" = {
          id = "vlczak-pictures";
          devices = [
            "krakatice"
            "tucnak"
            "ustrice"
          ];
        };
        "~/Programming" = {
          id = "vlczak-programming";
          devices = [
            "krakatice"
            "tucnak"
            "ustrice"
          ];
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
          id = "X7N5G26-ES7BGE7-ASXEHHJ-DHUPBY7-CNLPHXU-RDEQKNS-2TIGU42-EYU3EAY";
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
