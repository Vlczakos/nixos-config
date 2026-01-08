{ ... }:
{
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
}