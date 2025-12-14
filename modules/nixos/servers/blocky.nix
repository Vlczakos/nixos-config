{ ... }:
{
  networking.firewall.allowedUDPPorts = [ 53 ];

  services.blocky = {
    enable = true;
    settings = {
      upstreams.groups.default = [
        "1.1.1.1"
        "8.8.8.8"
      ];

      customDNS = {
        customTTL = "30m";

        mapping = {
          "vlcak.com" = "192.168.1.90";
        };
      };

      blocking = {
        denylists = {
          ads = [ "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" ];
        };

        clientGroupsBlock = {
          default = [ "ads" ];
        };
      };
    };
  };
}
