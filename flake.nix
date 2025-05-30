{
  description = "This is definitely the last rewrite I'll do";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  };

  outputs =
    { self, home-manager, ... }@inputs:
    let
      inherit (inputs.nixpkgs) lib;
      system = "x86_64-linux";
      pkgsSet =
        let
          mkPkgs =
            pkgs:
            (import pkgs {
              inherit system;
              config = {
                allowUnfree = true;
              };
            });
        in
        {
          stable = mkPkgs inputs.nixpkgs;
          unstable = mkPkgs inputs.nixpkgs;
          config = mkPkgs ./pkgs;
        };
      commonArgs = {
        inherit
          inputs
          lib
          pkgsSet
          self
          system
          ;
      };
    in
    {
      nixosModules = (import ./modules/system commonArgs) // {
        profiles = import ./profiles/system commonArgs;
      };
      nixosConfigurations = import ./hosts commonArgs;
      homeManagerModules = (import ./modules/home commonArgs) // {
        profiles = import ./profiles/home commonArgs;
      };
      homeConfigurations = import ./homes commonArgs;
      lib = import ./lib {
        inherit lib;
      };
      formatter.${system} = pkgsSet.stable.nixfmt-rfc-style;
      devShells.${system}.default = pkgsSet.stable.mkShell {
        inherit (self.checks.${system}.pre-commit-check) shellHook;
        buildInputs = [
          pkgsSet.unstable.nixd
          pkgsSet.unstable.lua-language-server
          pkgsSet.unstable.nixfmt-rfc-style
          pkgsSet.unstable.nix-output-monitor
          pkgsSet.unstable.nodePackages_latest.typescript-language-server
        ];
      };
      checks.${system} = {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixfmt-rfc-style.enable = true;
          };
        };
      };
    };
}
