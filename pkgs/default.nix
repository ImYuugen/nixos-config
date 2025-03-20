{ pkgs, ... }:
{
  slippi-launcher = pkgs.callPackage ./slippi.nix { };
}
