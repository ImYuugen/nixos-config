{ config, lib, ... }:

let
  cfg = config.modules.programs.shell.fish;
in
{
  options.modules.programs.shell.fish = {
    enable = lib.mkEnableOption "Fish";
    viBindings = lib.mkEnableOption "Vi keybinds";
  };

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = lib.mkDefault true;
      interactiveShellInit = lib.mkDefault (
        lib.strings.optionalString cfg.viBindings "fish_vi_key_bindings"
      );
    };
  };
}
