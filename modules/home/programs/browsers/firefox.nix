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
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = lib.mkDefault true;
      # TODO: Default config
    };
  };
}
