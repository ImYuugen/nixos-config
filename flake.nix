{
  description = "3rd time surely is the charm";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    # For command-not-found
    fps = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nil.url = "github:oxalica/nil";
  };

  outputs = {
    self,
    home-manager,
    ...
  } @ inputs: let
    lib = inputs.nixpkgs.lib // home-manager.lib;
  in inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [ "x86_64-linux" ];
    perSystem = {
      system,
      ...
    }: let
      pkgs = with inputs; {
        stable = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations = (
        import ./hosts {
        # TODO: Add options for modularity
          inherit inputs lib pkgs;
        }
      );
    
      formatter = pkgs.stable.alejandra;
      devShells.default = pkgs.stable.mkShell {
        buildInputs = [
          inputs.nil.packages.${system}.default
        ];
      };
    };
  };
}
