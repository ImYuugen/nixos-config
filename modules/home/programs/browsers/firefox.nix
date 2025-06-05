{
  config,
  lib,
  ...
}:

let
  cfg = config.modules.programs.browsers.firefox;
in
{
  options.modules.programs.browsers.firefox = {
    enable = lib.mkEnableOption "Firefox";
    defaultBrowser = lib.mkEnableOption "Firefox as default browser";
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables.BROWSER = lib.mkIf cfg.defaultBrowser "firefox";

    programs.firefox = {
      enable = lib.mkDefault true;
      # TODO: Default config
    };
  };
}
