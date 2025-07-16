{ config, lib, ... }:

let
  cfg = config.modules.security.doas;
in
{
  options.modules.security.doas = {
    enable = lib.options.mkEnableOption "OpenDoas";
    extraRules = lib.options.mkOption {
      default = [
        {
          persist = true;
          setenv = [ "PATH" ];
          groups = [ "wheel" ];
        }
      ];
      example = {
        nopass = true;
        groups = [ "wheel" ];
        cmd = "nixos-rebuild";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    security = {
      sudo.enable = lib.mkDefault false;
      doas = {
        enable = lib.mkDefault true;
        extraRules = lib.mkDefault cfg.extraRules;
      };
    };
  };
}
