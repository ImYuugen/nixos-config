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

    hyprcursor.url = "github:hyprwm/hyprcursor";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland/?submodules=1";
    hyprlock.url = "github:hyprwm/hyprlock";
    hyprpaper.url = "github:hyprwm/hyprpaper";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    hypr-contrib.url = "github:hyprwm/contrib";

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nil.url = "github:oxalica/nil";

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    spicetify-nix.url = "github:the-argus/spicetify-nix";

    wezterm.url = "github:wez/wezterm?dir=nix";
  };

  outputs =
    { self
    , home-manager
    , ...
    } @ inputs:
    let
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
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit inputs lib pkgsSet;
        }
      );
      formatter.${system} = pkgsSet.stable.nixpkgs-fmt;
      devShells.${system}.default = pkgsSet.stable.mkShell {
        inherit (self.checks.${system}.pre-commit-check) shellHook;
        buildInputs = [
          inputs.nil.packages.${system}.default
        ];
      };
      checks.${system} = {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixpkgs-fmt.enable = true;
          };
        };
      };
    };
}
