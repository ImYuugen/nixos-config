{ config, pkgs, ... }:
{
  programs.gpg = {
    enable = true;
    package = pkgs.gnupg;
  };
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };
}
