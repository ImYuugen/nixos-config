{
  description = "My *new* NixOs config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-root.url = "github:srid/flake-root";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fps = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nil.url = "github:oxalica/nil";
    rust-overlay.url = "github:oxalica/rust-overlay";

# Xorg
    picom.url = "github:yaocccc/picom";

# Wayland
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprcursor.url = "github:hyprwm/hyprcursor";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland/?submodules=1";
    hyprlock.url = "github:hyprwm/hyprlock";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    hypr-contrib.url = "github:hyprwm/contrib";
  };

  outputs = inputs @ { self, nixpkgs, flake-parts, ... }:
    let
      user = "yuugen";
      system = "x86_64-linux";
      confPkgs = import ./pkgs;
      unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [ inputs.flake-root.flakeModule ];
      perSystem = { config, inputs', pkgs, system, lib, ... }:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              self.overlays.default
            ];
          };
        in
        {
          flake-root.projectRootFile = "flake.nix";
          formatter = pkgs.nixpkgs-fmt;
          devShells.default = pkgs.mkShell {
            inputsFrom = [ config.flake-root.devShell ];
            buildInputs = with pkgs; [
              inputs.nil.packages.${system}.default
              nixpkgs-fmt
            ];
          };
        };
      
      flake = {
        overlays.default = confPkgs.overlay;
        nixosConfigurations = (
          import ./hosts {
            wayland = true;
            inherit nixpkgs self inputs unstable user system;
          }
        );
      };
    };
}
