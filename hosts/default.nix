{ inputs, lib, pkgs, ... }:
let
  shared = [
    ./shared
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.yuugen = {
          imports = [
            ../home/yuugen
          ];
        };
      };
    }
  ];
in {
  omen = lib.nixosSystem {
    specialArgs = { inherit inputs lib pkgs; };
    modules = [
      ./omen
    ] ++ shared;
  };
}
