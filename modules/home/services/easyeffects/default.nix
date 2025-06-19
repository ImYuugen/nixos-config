{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.services.easyeffects;
  presetType =
    let
      baseType = lib.types.attrsOf (pkgs.formats.json { }).type;
    in
    baseType
    // {
      check =
        v:
        baseType.check v
        && lib.elem (lib.head (lib.attrNames v)) [
          "input"
          "output"
        ];
      description = "EasyEffects input or output JSON preset";
    };
in
{
  options.modules.services.easyeffects = {
    enable = lib.mkEnableOption "Easyeffects";
    withDefaultPresets = lib.mkEnableOption "With general presets";
    extraExtraPresets = lib.mkOption {
      default = { };
      type = lib.types.nullOr (lib.types.attrsOf presetType);
    };
  };

  config = lib.mkIf cfg.enable {
    services.easyeffects = {
      enable = lib.mkDefault true;
      extraPresets =
        (lib.mkIf cfg.withDefaultPresets {
          advanced-autogain = builtins.fromJSON (builtins.readFile ./presets/advanced-autogain.json);
        })
        // (cfg.extraExtraPresets or { });
    };
  };
}
