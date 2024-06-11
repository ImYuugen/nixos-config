{ inputs
, lib
, pkgsSet
, ...
}:
let
  shared = [
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    }
    # Fix command-not-found
    inputs.fps.nixosModules.programs-sqlite
  ];
in
{
  # HP Omen Laptop
  omen = lib.nixosSystem {
    specialArgs = { inherit inputs lib pkgsSet; };
    modules =
      [
        ./omen
        ../home/yuugen
      ]
      ++ shared;
  };
}
