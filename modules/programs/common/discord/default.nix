{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (discord.override {
      withOpenASAR = true;
    })
    betterdiscordctl
  ];
}
