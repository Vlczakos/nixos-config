{ ... }:
{
  services.openssh = {
    enable = true;

    settings = {
      UseDns = true;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
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