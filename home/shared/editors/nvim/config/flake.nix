{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    rustacean = {
      url = "github:mrcjkb/rustaceanvim";
    };
  };
  outputs =
    { nixpkgs, rustacean, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          lua-language-server
          stylua
          rustacean.packages.${system}.codelldb
        ];
      };
    };
}
