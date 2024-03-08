{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    jq
    nodejs_20
    yarn
  ];
}
