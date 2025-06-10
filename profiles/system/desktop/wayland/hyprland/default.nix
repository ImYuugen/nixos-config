{ lib, ... }:

{
  programs.hyprland = {
    enable = lib.mkDefault true;
  };

  xdg.portal = {
    enable = lib.mkDefault true;
    wlr.enable = lib.mkDefault true;
  };
}
