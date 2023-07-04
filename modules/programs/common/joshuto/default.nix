{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    file joshuto
  ];
}
