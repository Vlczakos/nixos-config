{ inputs, config, ... }:
{
    imports = [
      inputs.home_manager.nixosModules.home-manager
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = { inherit inputs; nixos-config = config; };

      sharedModules = [ ./../../home_manager/shared ];
    };
}