{ inputs, lib, pkgs, ... }:
let
  shared = [
    ../home/shared
    inputs.home-manager.nixosModules.default
  ];
in {
  omen = lib.nixosSystem {
    specialArgs = { inherit inputs lib; };
    modules = [
      ./omen
      ../home/omen
    ] ++ shared;
  };
}
