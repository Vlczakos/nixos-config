{
  config,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    libglvnd
    mesa
  ];

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  boot.kernelParams = [ "nvidia-drm.fbdev=1" ];

  hardware.graphics.enable = true;

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
