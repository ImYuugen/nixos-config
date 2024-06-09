{...}: {
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
          exec = [
            "hyprctl keyword monitor eDP-1, 1920x1080@144Hz, 0x0, 1"
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
              status = "enable";
              mode = "--custom 1920x1080@144Hz";
            }
            {
              criteria = "HDMI-A-1";
              status = "enable";
              mode = "1920x1080";
            }
          ];
          exec = [
            "hyprctl keyword monitor eDP-1, 1920x1080@144Hz, 0x0, 1"
            "hyprctl dispatch moveworkspacetomonitor 7 HDMI-A-1"
            "hyprctl dispatch moveworkspacetomonitor 8 HDMI-A-1"
            "hyprctl dispatch moveworkspacetomonitor 9 HDMI-A-1"
            "hyprctl dispatch moveworkspacetomonitor 0 HDMI-A-1"
          ];
        };
      }
    ];
    systemdTarget = "hyprland-session.target";
  };
}
