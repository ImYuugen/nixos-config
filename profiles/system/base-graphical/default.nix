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
    libnotify
    libva
    libva-utils
  ];
}
