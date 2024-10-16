{ ... }:
{
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
              mode = "--custom 1920x1080@144Hz";
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
          name = "Huion_Kamvas_undocked_usb_c";
          outputs = [
            {
              criteria = "eDP-1";
              status = "enable";
              mode = "--custom 1920x1080@144Hz";
            }
            {
              criteria = "HAT Kamvas Pro 16 0xF0000001";
              status = "enable";
              mode = "2560x1440";
            }
          ];
        };
      }
      {
        profile = {
          name = "Samsung_left";
          outputs = [
            {
              criteria = "eDP-1";
              status = "enable";
              mode = "--custom 1920x1080@144Hz";
              position = "1920,0";
              adaptiveSync = true;
            }
            {
              criteria = "Samsung Electric Company S22F350 H4ZJ700738";
              status = "enable";
              mode = "1920x1080";
              position = "0,0";
              adaptiveSync = true;
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
