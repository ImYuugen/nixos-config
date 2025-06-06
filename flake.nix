{
  description = "3rd time surely is the charm";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nil.url = "github:oxalica/nil";

    # For command-not-found
    fps = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    lz.url = "github:nvim-neorocks/lz.n";

    ags.url = "github:Aylur/ags";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    hypr-contrib.url = "github:hyprwm/contrib";
  };

  outputs =
    { self, home-manager, ... }@inputs:
    let
      lib = inputs.nixpkgs.lib // home-manager.lib;
      system = "x86_64-linux";
      pkgsSet = with inputs; {
        stable = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [ ];
        };
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
        confPkgs = import ./pkgs { pkgs = pkgsSet.stable; };
      };
    in
    {
      nixosConfigurations = (import ./hosts { inherit inputs lib pkgsSet; });
      formatter.${system} = pkgsSet.stable.nixfmt-rfc-style;
      devShells.${system}.default = pkgsSet.stable.mkShell {
        inherit (self.checks.${system}.pre-commit-check) shellHook;
        buildInputs = [
          inputs.nil.packages.${system}.default
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
