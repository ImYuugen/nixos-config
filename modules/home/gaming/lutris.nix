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
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.umu-launcher ];
    programs.lutris = {
      enable = lib.mkDefault true;
      protonPackages = [ pkgs.proton-ge-bin ];
      winePackages = [ pkgs.wineWow64Packages.full ];
    };
  };
}
