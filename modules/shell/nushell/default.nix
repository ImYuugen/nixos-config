{ pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    shellAliases = {
    };
    configFile.source = ./config.nu;
    envFile.text = ''
    '';
    extraEnv = ''
    '';
    environmentVariables = {
    };
    extraConfig = ''
    '';
  };
}
