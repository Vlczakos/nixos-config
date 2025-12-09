{ ... }:
{
  services.syncthing = {
    enable = true;
    dataDir = "/etc/syncthing";

    settings = {
      devices = {
        "krakatice" = {
          id = "PLACEHOLDER";
          addresses = [ "10.20.30.90" ];
        };
        "tucnak" = {
          id = "I3SB3GU-JT56N2A-D376G5E-2AJ3XKK-W5LRERJ-AR7SUGA-P2RSZ5Y-WOFYWAQ";
        };
        "meduza" = {
          id = "PLACEHOLDER";
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
