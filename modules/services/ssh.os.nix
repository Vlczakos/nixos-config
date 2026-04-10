{ lib, config, ... }:
{
  options.custom.services.ssh = {
    enable = lib.mkEnableOption "ssh";
  };

  config = lib.mkIf config.custom.services.ssh.enable {
    services.openssh = {
      enable = true;

      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        AllowStreamLocalForwarding = "yes";
      };
    };

    services.fail2ban = {
      maxretry = 3;

      bantime = "24h";

      bantime-increment = {
        enable = true;
        rndtime = "1h";
      };
    };
  };
}
