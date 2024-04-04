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
      
      docked = {
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
    };
    systemdTarget = "graphical-session.target";
  };
}
