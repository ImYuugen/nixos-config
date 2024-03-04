{ config, lib, pkgs, user, ... }:

{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });

    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
    
    style = builtins.readFile ./style.css;
    settings = import ./bars.nix;
  };
}
