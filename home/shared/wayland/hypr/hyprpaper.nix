{ inputs
, pkgsSet
, ...
}: {
  services.hyprpaper = {
    enable = true;
    package = inputs.hyprpaper.packages.${pkgsSet.stable.system}.hyprpaper;
    settings = {
      # TODO: Owollpaper
      misc = {
        splash = false;
      };
    };
  };
}
