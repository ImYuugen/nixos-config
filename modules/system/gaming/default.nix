{ lib, ... }:

{
  dualsense = import ./dualsense.nix;
  gamecube = import ./gamecube.nix;
  gamemode = import ./gamemode.nix;
  steam = import ./steam.nix;
}
