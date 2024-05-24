{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    macchina
  ];

  home.file.".config/macchina/macchina.toml".text = ''
  '';
}
