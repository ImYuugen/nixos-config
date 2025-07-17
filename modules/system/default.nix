{ lib, ... }:

{
  audio = import ./audio.nix;
  dev = import ./dev { };
  gaming = import ./gaming { inherit lib; };
  hardware = import ./hardware { inherit lib; };
  kde = import ./kde.nix;
  networking = import ./networking { inherit lib; };
  plymouth = import ./plymouth.nix;
  power = import ./power { inherit lib; };
  security = import ./security { inherit lib; };
  virtualisation = import ./virtualisation { inherit lib; };
}
