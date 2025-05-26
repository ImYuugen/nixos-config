{
  description = "3rd time surely is the charm";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nil.url = "github:oxalica/nil";
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
        };
    in
    {
      lib = import ./lib {
        inherit lib;
      };
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
