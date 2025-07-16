{
  config,
  lib,
  pkgsSet,
  ...
}:

let
  cfg = config.modules.gaming.lutris;
  pkgs = pkgsSet.unstable;
in
{
  options.modules.gaming.lutris = {
    enable = lib.mkEnableOption "Lutris";
    withIcons = lib.mkEnableOption "Default icons for lutris";
  };

  config = lib.mkIf cfg.enable {
    home.packages =
      with pkgs;
      [
        umu-launcher
        winetricks
        wineWowPackages.full
      ]
      ++ lib.lists.optional cfg.withIcons pkgs.adwaita-icon-theme;
    programs.lutris = {
      enable = lib.mkDefault true;
      protonPackages = [ pkgs.proton-ge-bin ];
      winePackages = [ pkgs.wineWow64Packages.full ];
    };
  };
}
