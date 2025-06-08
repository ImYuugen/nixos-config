{ lib, ... }:

{
  dunst = import ./dunst.nix;
  rofi = import ./rofi.nix;
  wayland = import ./wayland { inherit lib; };
}
