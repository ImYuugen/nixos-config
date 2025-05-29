{ lib, ... }:

{
  audio = import ./audio.nix;
  hardware = import ./hardware { inherit lib; };
  networking = import ./networking { inherit lib; };
  power = import ./power { inherit lib; };
  security = import ./security { inherit lib; };
}
