{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.desktop.wayland.hyprcursor;
  mkMiniDefault = lib.mkOverride 1001;
in
{
  options.modules.desktop.wayland.hyprcursor = {
    enable = lib.mkEnableOption "Hyprcursor";
    cursor = {
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.bibata-cursors;
        description = "Package providing the cursor.";
      };
      name = lib.mkOption {
        type = lib.types.str;
        default = "Bibata-Modern-Ice";
        description = "The cursor name within the package.";
      };
      size = lib.mkOption {
        type = lib.types.int;
        default = 20;
        description = "The cursor size";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.pointerCursor = {
      # mkDefault clashes with modules
      name = mkMiniDefault cfg.cursor.name;
      package = mkMiniDefault cfg.cursor.package;
      size = mkMiniDefault cfg.cursor.size;
      gtk.enable = lib.mkDefault true;
      hyprcursor.enable = lib.mkDefault true;
    };
  };
}
