{
  description = "My nixos config";

  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:nixos/nixpkgs";
    nur.url = "github:nix-community/NUR";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nix-shell.url = "github:Mic92/nixos-shell";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-root.url = "github:srid/flake-root";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprpicker.url = "github:hyprwm/hyprpicker";

    hypr-contrib.url = "github:hyprwm/contrib";

    joshuto.url = "github:kamiyaa/joshuto";

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nil.url = "github:oxalica/nil";

    nixd.url = "github:nix-community/nixd";

    picom.url = "github:yaocccc/picom";

    rust-overlay.url = "github:oxalica/rust-overlay";

    statix = {
      url = "github:nerdypepper/statix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, flake-parts, ... }:
    let
      user = "yuugen";
      selfPkgs = import ./pkgs;
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [ inputs.flake-root.flakeModule ];
      perSystem = { config, inputs', pkgs, system, lib, ... }:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              self.overlays.default
            ];
          };
        in
        {
          flake-root.projectRootFile = "flake.nix";
          devShells.default = pkgs.mkShell {
            inputsFrom = [ config.flake-root.devShell ];
          };
        };

      flake = {
        overlays.default = selfPkgs.overlay;
        nixosConfigurations = (
          import ./hosts {
            system = "x86_64-linux";
            inherit nixpkgs self inputs user;
          }
        );
      };
    };
}
