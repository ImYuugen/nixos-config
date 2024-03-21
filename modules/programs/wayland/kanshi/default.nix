{ config, pkgs, ... }:

{
  services.kanshi = {
    enable = true;
    profiles = {
      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
            scale = 1.0;
            status = "enable";
          }
        ];
      };
      
      docked = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "DP-2";
            scale = 1.0;
            mode = "1920x1080@144Hz";
            status = "enable";
          }
        ];
      };
    };
    systemdTarget = "hyprland-session.target";
  };
}
