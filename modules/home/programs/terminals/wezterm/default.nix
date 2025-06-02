{ config, lib, ... }:

let
  cfg = config.modules.programs.terminals.wezterm;
in
{
  options.modules.programs.terminals.wezterm = {
    enable = lib.mkEnableOption "Wezterm";
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables.TERMINAL = lib.mkDefault "wezterm";

    programs.wezterm = {
      enable = lib.mkDefault true;
      enableBashIntegration = lib.mkDefault true;
      enableZshIntegration = lib.mkDefault true;
    };
  };
}
