{ config, lib, ... }:

let
  cfg = config.modules.programs.shells.bash;
in
{
  options.modules.programs.shells.bash = {
    enable = lib.mkEnableOption "Bash";
    viBindings = lib.mkEnableOption "Vi keybinds";
  };

  config = lib.mkIf cfg.enable {
    home.shell.enableBashIntegration = lib.mkDefault true;

    programs.bash = {
      enable = lib.mkDefault true;
      enableCompletion = lib.mkDefault true;
      initExtra = lib.mkDefault (lib.strings.optionalString cfg.viBindings "set -o vi");
    };
  };
}
