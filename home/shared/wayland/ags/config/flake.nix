{
  description = "My Awesome Desktop Shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=staging-24.11";

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ags,
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system} = {
        default = ags.lib.bundle {
          inherit pkgs;
          src = ./.;
          name = "my-shell";
          entry = "app.ts";

          # additional libraries and executables to add to gjs' runtime
          extraPackages = [
            # ags.packages.${system}.battery
            # pkgs.fzf
          ];
        };
      };

      devShells.${system} = {
        default = pkgs.mkShell {
          buildInputs = [
            pkgs.nodePackages_latest.typescript-language-server
            pkgs.nodePackages_latest.prettier
            pkgs.dart-sass
            pkgs.vscode-langservers-extracted
            ags.packages.${system}.agsFull

          ];
        };
      };
    };
}
