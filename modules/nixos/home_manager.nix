{ inputs, ... }:
{
    imports = [
      inputs.home_manager.nixosModules.home-manager
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = { inherit inputs; };

      sharedModules = [ ./../home_manager ];
    };
}