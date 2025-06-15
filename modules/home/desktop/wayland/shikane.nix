{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.desktop.wayland.shikane;
in
{

  options.modules.desktop.wayland.shikane = {
    enable = lib.mkEnableOption "Shikane dynamically manages displays.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.shikane
    ];

    services.shikane = {
      enable = lib.mkDefault true;
      # TODO: Find a way to mix on-the-fly configs, added outside of Nix
      # and declarative configs
      #
      # Possible: if config file doesn't exist, create it (outside of store)
      # and include the generated config
    };
  };
}
