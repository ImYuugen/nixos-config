{ config, inputs, pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;
    package = inputs.hyprlock.packages.${pkgs.system}.hyprlock;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = false;
        no_fade_in = true;
      };

      input-field = [
        {
          size = "300, 50";
          outline_thickness = 1;
          fade_on_empty = false;
          placeholder_text = "nanani nanana eh gros..";
          dots_spacing = 0.2;
          dots_center = true;
        }
      ];

      label = [
        {
          text = "Shimmy shimmy yay shimmy ya shimmy yawa";
          font_size = 50;
          position = "0, 80";
          valign = "center";
          halign = "center";
        }
      ];
    };
  };
}
