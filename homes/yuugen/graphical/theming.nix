{
  config,
  inputs,
  pkgs,
  self,
  ...
}:

{
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  stylix = {
    enable = true;
    autoEnable = true;
    # Use `colors` to set your own
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
    image = "${self.outPath}/assets/images/ceci.png";
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
        package = pkgs.noto;
        name = "Noto Color Emoji";
      };
    };
    # Modules
    emacs.enable = false; # Managed directly through config
    hyprlock.enable = false;
  };

  gtk.enable = true;
  qt.enable = true;
}
