{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    jq
    nodePackages_latest.nodejs
    yarn
    yarn2nix
  ];
}
