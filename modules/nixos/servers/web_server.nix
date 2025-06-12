{ ... }:
{
  services.static-web-server = {
    enable = true;
    root = "/srv/project_vyt";
    listen = "0.0.0.0:80";
  };

  
}