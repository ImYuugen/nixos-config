{
  inputs,
  lib,
  pkgsSet,
  self,
  system,
  ...
}:

{
  omen = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit
        inputs
        pkgsSet
        self
        ;
    };
    modules = [
      {
        system.name = "omen";
        nix.registry = {
          nixpkgs.flake = inputs.nixpkgs;
          nixpkgs-unstable.flake = inputs.nixpkgs-unstable;
        };
        nixpkgs.pkgs = pkgsSet.stable;
      }
      ./omen
    ];
  };
}
