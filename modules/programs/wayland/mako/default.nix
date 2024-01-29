{ config, pkgs, ... }:

{
  services.mako.enable = true;

  # TODO: Config
  home.file.".config/mako/config".text = ''
  '';
}
