{
  inputs = {
    nixpkgs = "github:nixos/nixpkgs/nixos-24.05";
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      system = "86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          typescript-language-server
          prettierd
        ];
      };
    };
}
