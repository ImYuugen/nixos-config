{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.desktop.wayland.grimblast;
in
{
  options.modules.desktop.wayland.grimblast = {
    enable = lib.mkEnableOption "Grimblast";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    ];
  };
}
