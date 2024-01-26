{ config, lib, pkgs, user, ... }:

{
#	  home.packages = [ pkgs.waybar ];
#	  nixpkgs.overlays = [
#	    (final: prev: {
#	      waybar = prev.waybar.overrideAttrs (oldAttrs: {
#		mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
#		postPatch = (oldAttrs.postPatch or "") + ''
#		  sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp
#		'';
#	      });
#	    })
#	  ];
  programs.waybar = {
    enable = true;
    #systemd.enable = false;
    #systemd.target = "graphical-session.target";
  };
}
