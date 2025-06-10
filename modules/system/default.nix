{ lib, ... }:

{
  audio = import ./audio.nix;
  dev = import ./dev { };
  gaming = import ./gaming { inherit lib; };
  hardware = import ./hardware { inherit lib; };
  networking = import ./networking { inherit lib; };
  power = import ./power { inherit lib; };
  security = import ./security { inherit lib; };
  virtualisation = import ./virtualisation { inherit lib; };
}
