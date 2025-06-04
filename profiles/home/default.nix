{ ... }:

{
  base = import ./base.nix;
  base-graphical = import ./base-graphical.nix;
  desktop = import ./desktop { };
}
