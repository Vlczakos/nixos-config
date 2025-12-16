{ ... }:
{
  home.username = "vlczak";
  home.homeDirectory = "/home/vlczak";

  services.syncthing.settings.folders = {
    "~/Pictures/Photos" = {
      versioning = {
        type = "trashcan";
        fsPath = "~/Pictures/PhotosDeleted";
      };
    };

    "~/Pictures" = {
      versioning = {
        type = "staggered";
        fsPath = "~/backup/Pictures";

        params = {
          cleanInterval = "3600";
          maxAge = "30";
        };
      };
    };

    "~/Documents" = {
      versioning = {
        type = "staggered";
        fsPath = "~/backup/Documents";

        params = {
          cleanInterval = "3600";
          maxAge = "30";
        };
      };
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
}
