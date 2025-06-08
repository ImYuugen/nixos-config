{
  config,
  lib,
  ...
}:

let
  cfg = config.modules.programs.communications.thunderbird;
in
{
  options.modules.programs.communications.thunderbird = {
    enable = lib.mkEnableOption "Thunderbird";
  };

  config = lib.mkIf cfg.enable {
    programs.thunderbird = {
      enable = true;
      profiles.${config.home.username} = {
        isDefault = true;
      };
    };
  };
}
