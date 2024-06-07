{
  description = "3rd time surely is the charm";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For command-not-found
    fps = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
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
    system = "x86_64-linux";
    pkgsSet = with inputs; {
      stable = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = (
      import ./hosts {
        inherit inputs lib pkgsSet;
      }
    );
    formatter.${system} = pkgsSet.stable.alejandra;
    devShells.${system}.default = pkgsSet.stable.mkShell {
      buildInputs = [
        inputs.nil.packages.${system}.default
      ];
    };
  };
}
