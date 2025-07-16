{ lib, ... }:

{
  ananicy = import ./ananicy.nix;
  dualsense = import ./dualsense.nix;
  gamecube = import ./gamecube.nix;
  gamemode = import ./gamemode.nix;
  steam = import ./steam.nix;
}
