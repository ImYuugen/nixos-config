{
  inputs,
  pkgsSet,
  ...
}: {
  programs.hyprlock = {
    enable = true;
    # package = inputs.hyprlock.packages.${pkgsSet.stable.system}.hyprlock;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = false;
        no_fade_in = true;
        no_fade_out = true;
        grace = 3;
      };
      background = {
        path = "screenshot";
        blur_passes = 5;
        blur_size = 7;
      };
      inputs-field = [
        {
          monitor = "";
          size = "300, 50";
          outline_thickness = 1;
          fade_on_empty = false;
          placeholder_text = ''<span>Swalalalaa (drank)...</span>'';
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
