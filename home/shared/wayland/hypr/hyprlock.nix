{ ... }:
{
  programs.hyprlock = {
    enable = true;
    # package = inputs.hyprlock.packages.${pkgsSet.stable.system}.hyprlock;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = false;
        no_fade_in = true;
        no_fade_out = true;
        grace = 1;
      };
      background = {
        path = "screenshot";
        blur_passes = 3;
        blur_size = 5;
        brightness = 0.75;
        noise = 5.0e-2;
      };
      inputs-field = [
        {
          monitor = "";
          size = "300, 50";
          outline_thickness = 3;
          dots_center = true;
          dots_size = 0.33;
          dots_spacing = 0.15;
          placeholder_text = ''<i>Swalalalaa (drank)...</i>'';
          hide_input = false;
          position = "0, 200";
          halign = "center";
          valign = "bottom";
        }
      ];
      label = [
        {
          monitor = "";
          text = "$TIME";
          font_size = 50;
          position = "0, 50";
          valign = "center";
          halign = "center";
        }
      ];
    };
  };
}
