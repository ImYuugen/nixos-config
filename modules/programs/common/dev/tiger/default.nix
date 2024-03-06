{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    autoconf automake
    bison boost
    flex reflex
    gnum4 gnumake
    libtool libxslt
    perl
  ];
}
