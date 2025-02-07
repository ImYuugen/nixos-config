{
  description = "3rd time surely is the charm";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
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

    emacs-overlay.url = "github:nix-community/emacs-overlay";

    ags.url = "github:Aylur/ags";
    hyprland.url = "github:hyprwm/hyprland";
    hyprcursor.url = "github:hyprwm/hyprcursor";
    hyprpaper.url = "github:hyprwm/hyprpaper";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    hypr-contrib.url = "github:hyprwm/contrib";

    slippi = {
      url = "github:NormalFall/ssbm-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    umu = {
      url = "git+https://github.com/Open-Wine-Components/umu-launcher/?dir=packaging\/nix&submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wezterm.url = "github:wez/wezterm?dir=nix";
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
          overlays = [ inputs.emacs-overlay.overlay ];
        };
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
        confPkgs = import ./pkgs;
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
