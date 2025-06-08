{ lib, ... }:

{
  dunst = import ./dunst.nix;
  fcitx5 = import ./fcitx5.nix;
  rofi = import ./rofi.nix;
  wayland = import ./wayland { inherit lib; };
}
