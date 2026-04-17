{ ... }:
{
  home.file = {
    "Programming/.stignore" = {
      force = true;
      text = ''
        target
        .direnv
      '';
    };
    "Pictures/.stignore" = {
      force = true;
      text = ''
        /Photos
      '';
    };
  };
}
