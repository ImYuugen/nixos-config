{ config, pkgs, ... }:

{
  home.packages = [ pkgs.kanshi ];

  services.kanshi = {
    enable = true;
    profiles = {
      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
            scale = 1.0;
            position = "0,0";
            status = "enable";
          }
        ];
      };

      docked-dp = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "DP-2";
            mode = "1920x1080@144Hz";
            position = "0,0";
            scale = 1.0;
            status = "enable";
          }
        ];
      };

      docked-hdmi = {
        outputs = [
          {
            criteria = "eDP-1";
            mode = "1920x1080@144Hz";
            position = "0x0";
          }
          {
            criteria = "HDMI-1";
            mode = "1920x1080";
            position = "0x0";
          }
        ];
      };
    };
    systemdTarget = "graphical-session.target";
  };
}
