{ ... }:
{
  programs.git = {
    enable = true;

    signing.format = "openpgp";

    settings.user = {
      email = "david@vlcak.com";
      name = "Vlczakos";
    };
  };
}