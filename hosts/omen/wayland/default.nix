{ config, inputs, lib, pkgs, user, ... }:

{
  imports = [
    ../../../modules/desktop/hyprland    
  ];

  nix = {
    settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
  };

  environment = {
    systemPackages = with pkgs; [
      wayland wayland-scanner wayland-utils xwayland
      wlroots wlrctl wlr-protocols wlr-randr xdg-desktop-portal-wlr
      egl-wayland glfw-wayland wine-wayland
      
      swayidle qt6.qtwayland wev
    ];
  };
}
