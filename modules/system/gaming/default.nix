{ lib, ... }:

{
  dualsense = import ./dualsense.nix;
  gamemode = import ./gamemode.nix;
  steam = import ./steam.nix;
}
