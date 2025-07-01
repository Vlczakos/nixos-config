{ ... }:
{
  # Audio
  services.pipewire = {
    enable = true;

    audio.enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    wireplumber.enable = true;

    
  };
}
