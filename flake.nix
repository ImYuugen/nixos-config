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

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    esp-idf.url = "github:mirrexagon/nixpkgs-esp-dev";
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
          unstable = (mkPkgs inputs.nixpkgs) // {
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
