{
  ...
}:
{
  imports = [
    ./nvidia.nix
  ];

  hardware.nvidia = {
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0@0:2:0";
      nvidiaBusId = "PCI:1@0:0:0";
    };

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = true;
  };

  # specialisation.gaming.configuration = {
  #   hardware.nvidia = {
  #     prime = {
  #       sync.enable = lib.mkForce true;

  #       offload = {
  #         enable = lib.mkForce false;
  #         enableOffloadCmd = lib.mkForce false;
  #       };
  #     };

  #     powerManagement.finegrained = lib.mkForce false;
  #   };
  # };
}
