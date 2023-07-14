{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    element-desktop-wayland
  ];
}
