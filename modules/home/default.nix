{ lib, ... }:

{
  desktop = import ./desktop { inherit lib; };
  gaming = import ./gaming { inherit lib; };
  programs = import ./gaming { inherit lib; };
  services = import ./services { inherit lib; };
}
