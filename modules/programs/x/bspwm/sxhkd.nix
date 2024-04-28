{ config, pkgs, ... }:
let
  super = "super";
  appSuper = "alt + shift";
in
{
  services.sxhkd = {
    enable = true;
    keybindings = {
      "${super} + {_,shift + }Return" = "$TERMINAL {_,--class='termfloat'}";
      "${super} + {_,shift + }q" = "bspc node -{c,k}";
      "${super} + shift + Escape" = "pkill -USR1 -x sxhkd";
    };
  };
}
