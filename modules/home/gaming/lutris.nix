{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.gaming.lutris;
in
{
  options.modules.gaming.lutris = {
    enable = lib.mkEnableOption "Lutris";
    withIcons = lib.mkEnableOption "Default icons for lutris";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.umu-launcher ] ++ lib.lists.optional cfg.withIcons pkgs.adwaita-icon-theme;
    programs.lutris = {
      enable = lib.mkDefault true;
      protonPackages = [ pkgs.proton-ge-bin ];
      winePackages = [ pkgs.wineWow64Packages.full ];
    };
  };
}
