{ config, lib, ... }:

let
  cfg = config.modules.programs.shell.bash;
in
{
  options.modules.programs.shell.bash = {
    enable = lib.mkEnableOption "Bash";
    viBindings = lib.mkEnableOption "Vi keybinds";
  };

  config = lib.mkIf cfg.enable {
    programs.bash = {
      enable = lib.mkDefault true;
      enableCompletion = lib.mkDefault true;
      initExtra = lib.mkDefault (lib.strings.optionalString cfg.viBindings "set -o vi");
    };
  };
}
