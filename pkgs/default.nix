{ pkgs, ... }:
{
  slippi-launcher = pkgs.callPackage ./slippi.nix { };
  stm32cubeide = pkgs.callPackage ./stm32cubeide.nix { };
}
