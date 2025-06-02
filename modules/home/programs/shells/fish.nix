{ config, lib, ... }:

let
  cfg = config.modules.programs.shells.fish;
in
{
  options.modules.programs.shells.fish = {
    enable = lib.mkEnableOption "Fish";
    viBindings = lib.mkEnableOption "Vi keybinds";
  };

  config = lib.mkIf cfg.enable {
    home.shell.enableFishIntegration = lib.mkDefault true;

    programs.fish = {
      enable = lib.mkDefault true;
      interactiveShellInit = lib.mkDefault (
        lib.strings.optionalString cfg.viBindings "fish_vi_key_bindings"
      );
    };
  };
}
