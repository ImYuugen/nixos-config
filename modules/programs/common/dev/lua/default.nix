{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    luajit
    lua-language-server
  ];
}
