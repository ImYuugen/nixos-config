{ config, pkgs, ... }:

{
  home.packages = [ pkgs.kanshi ];

  services.kanshi = {
    enable = true;
    settings = [
      {
        profile = {
          name = "undocked";
          outputs = [
            {
              criteria = "eDP-1";
              status = "enable";
            }
          ];
        };
      }
      {
        profile = {
          name = "AOC";
          outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
            }
            {
              criteria = "AOC 2460G4 0x00012CF6";
              status = "enable";
              mode = "--custom 1920x1080@144Hz";
            }
          ];
        };
      }
      {
        profile = {
          name = "HDMI_Hotplug";
          outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
            }
            {
              criteria = "HDMI-1";
              status = "enable";
              mode = "1920x1080";
            }
          ];
          exec = [
            "hyprctl dispatch moveworkspacetomonitor 7 HDMI-1"
            "hyprctl dispatch moveworkspacetomonitor 8 HDMI-1"
            "hyprctl dispatch moveworkspacetomonitor 9 HDMI-1"
            "hyprctl dispatch moveworkspacetomonitor 0 HDMI-1"
          ];
        };
      }
    ];
    systemdTarget = "hyprland-session.target";
  };
}
