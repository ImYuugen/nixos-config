{ pkgs, config, ... }:

{
  services.spotifyd.enable = true;
  home.packages = with pkgs; [
    spotify
  ];
}
