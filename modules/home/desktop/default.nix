{ lib, ... }:

{
  rofi = import ./rofi.nix;
  wayland = import ./wayland { inherit lib; };
}
