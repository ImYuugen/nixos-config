{
  config,
  lib,
  pkgsSet,
  self,
  ...
}:

let
  pkgs = pkgsSet.stable;
in
{
  imports = [
    self.homeManagerModules.services.darkman
  ];

  modules.services.darkman = {
    enable = true;
    stylixIntegration = {
      enable = true;
      light = {
        base16Scheme = {
          system = "base16";
          name = "Everforest Light Medium";
          slug = "everforest-light-medium";
          variant = "light";
          author = "Sainnhe Park (https =//github.com/sainnhe)";
          palette = {
            base00 = "#fdf6e3";
            base01 = "#f4f0d9";
            base02 = "#e6e2cc";
            base03 = "#939f91";
            base04 = "#829181";
            base05 = "#708089";
            base06 = "#fdf6e3";
            base07 = "#e6e2cc";
            base08 = "#e66868";
            base09 = "#f57d26";
            base0A = "#dfa000";
            base0B = "#8da101";
            base0C = "#35a77c";
            base0D = "#3a94c5";
            base0E = "#df69ba";
            base0F = "#829181";
          };
        };
        image = "${self.outPath}/assets/images/windup.png";
      };
      dark = {
        base16Scheme = {
          system = "base16";
          name = "Everforest Dark Medium";
          slug = "everforest-dark-medium";
          variant = "dark";
          author = "Sainnhe Park (https://github.com/sainnhe)";
          palette = {
            base00 = "#2d353b";
            base01 = "#343f44";
            base02 = "#3d484d";
            base03 = "#475258";
            base04 = "#7a8478";
            base05 = "#859289";
            base06 = "#9da9a0";
            base07 = "#d3c6aa";
            base08 = "#e67e80";
            base09 = "#e69875";
            base0A = "#dbbc7f";
            base0B = "#a7c080";
            base0C = "#83c092";
            base0D = "#7fbbb3";
            base0E = "#d699b6";
            base0F = "#514045";
          };
        };
        image = "${self.outPath}/assets/images/ceci.png";
      };
    };
  };

  stylix =
    let
      dm = config.modules.services.darkman.stylixIntegration.enable;
    in
    {
      enable = true;
      autoEnable = true;
      base16Scheme = lib.mkIf (!dm) "${pkgs.base16-schemes}/share/themes/everforest.yaml";
      image = lib.mkIf (!dm) "${self.outPath}/assets/images/ceci.png";
      fonts = {
        serif = {
          package = pkgs.moralerspace-nf;
          name = "Moralerspace Xenon NF";
        };
        sansSerif = {
          package = pkgs.moralerspace-nf;
          name = "Moralerspace Argon NF";
        };
        monospace = config.stylix.fonts.sansSerif;
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };
      # Modules
      targets = {
        emacs.enable = false; # Managed directly through config
        hyprlock.enable = false;
        firefox.profileNames = [ "Default" ];
      };
    };

  gtk.enable = true;
  qt.enable = true;
}
