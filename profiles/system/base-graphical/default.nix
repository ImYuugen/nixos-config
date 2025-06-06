{
  lib,
  pkgs,
  self,
  ...
}:

{
  key = ./.;

  environment.systemPackages = with pkgs; [
    brightnessctl
    libva
    libva-utils
  ];
}
