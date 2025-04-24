{ pkgs, inputs, ... }:
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-server = {
    enable = true;
    eula = true;

    servers = {
      server = {
        enable = true;
        package = pkgs.fabricServers.fabric-1_21_5;

        
      };
    };
  };
}