{ config, lib, ... }:

let
  cfg = config.modules.desktop.wayland.hyprcursor;
in
{
  options.modules.desktop.wayland.hyprcursor = {
    enable = lib.mkEnableOption "Hyprcursor";
    cursor = {
      package = lib.mkOption {
        type = lib.types.package;
        example = lib.literalExpression "pkgs.bibata-cursors";
        description = "Package providing the cursor.";
      };
      name = lib.mkOption {
        type = lib.types.str;
        example = "Bibata-Modern-Ice";
        description = "The cursor name within the package.";
      };
      size = lib.mkOption {
        type = lib.types.int;
        default = 20;
        example = 16;
        description = "The cursor size";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.pointerCursor = {
      inherit (cfg.cursor) name package size;
      gtk.enable = lib.mkDefault true;
      hyprcursor = {
        inherit (cfg.cursor) size;
        enable = lib.mkDefault true;
      };
    };
  };
}
