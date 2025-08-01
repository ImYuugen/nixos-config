{
  description = "This is definitely the last rewrite I'll do";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # For CachyOS kernel patches
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs.nixpkgs.follows = "";
    };

    esp-idf.url = "github:mirrexagon/nixpkgs-esp-dev";
    everforest.url = "git+https://codeberg.org/fwinter/everforest-nix.git";
    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-ssb.url = "github:imyuugen/nix-ssb";
    wakatime-ls = {
      url = "github:mrnossiom/wakatime-ls";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, ... }@inputs:
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
          stable = (mkPkgs inputs.nixpkgs) // {
            overlays = [ inputs.emacs-overlay.overlays.default ];
          };
          unstable = (mkPkgs inputs.nixpkgs-unstable) // {
            overlays = [ inputs.emacs-overlay.overlays.default ];
          };
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
        buildInputs = with pkgsSet.unstable; [
          nixd
          lua-language-server
          nixfmt-rfc-style
          nix-output-monitor
          bash-language-server
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
