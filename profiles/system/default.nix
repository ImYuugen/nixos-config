{ ... }:

{
  base = import ./base;
  base-graphical = import ./base-graphical;
  cachy = import ./cachy.nix;
  desktop = import ./desktop { };
}
