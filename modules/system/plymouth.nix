{
  config,
  lib,
  self,
  ...
}:

let
  cfg = config.modules.plymouth;
in
{
  options.modules.plymouth = {
    enable = lib.mkEnableOption "Plymouth";
  };

  config = lib.mkIf cfg.enable {
    boot = {
      plymouth = {
        enable = lib.mkDefault true;
        logo = lib.mkDefault "${self.outPath}/assets/images/nixos-logo-rainbow.png";
        theme = lib.mkDefault "breeze";
      };
    };
  };
}
