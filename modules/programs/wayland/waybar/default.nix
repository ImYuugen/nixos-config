{ config, pkgs, user, ... }:
{
  environment.systemPackages = [ pkgs.waybar ];

  home-manager.users.${user} = {
    programs.waybar = {
      enable = true;
      systemd = {
        enable = false;
        target = "graphical-session.target";
      };
      # TODO: Config
    };
  };
}
