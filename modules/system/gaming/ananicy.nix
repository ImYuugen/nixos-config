{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.gaming.ananicy;
in
{
  options.modules.gaming.ananicy = {
    enable = lib.mkEnableOption "Ananicy, an auto nice daemon";
  };

  config = lib.mkIf cfg.enable {
    services.ananicy = {
      enable = lib.mkDefault true;
      package = lib.mkDefault pkgs.ananicy-cpp;
    };
  };
}
