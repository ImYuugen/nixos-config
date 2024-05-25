{ config, pkgs, ... }:
let
  super = "super";
  preSelectMod = "ctrl + alt";
  appMod = "alt + shift";
in
{
  services.sxhkd = {
    enable = true;
    keybindings = {
      "${super} + {_,shift + }Return" = "$TERMINAL {_,--class='termfloat'}";
      "${super} + {_,shift + }q" = "bspc node -{c,k}";
      "${super} + shift + Escape" = "pkill -USR1 -x sxhkd";
      "${super} + {_,shift + }d" = "rofi -modi \"run, drun\" -show {drun,run}";

      "${appMod} + w" = "firefox";

      "${super} + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
      "${super} + shift + {a,d}" = "bspc node @/ -C {backward,forward}";
      "${super} + {t,f,m}" = "bspc node -t {tiled,floating,fullscreen}";
      "${super} + {h,j,k,l}" = "bspc node -f {west,south,north,east}";
      "${super} + {Left,Down,Up,Right}" = "bspc node -f {west,south,north,east}";
      "${super} + Tab" = "bspc node -f last";
      "${preSelectMod} + {h,j,k,l}" = "bspc node -p {west,south,north,east}";
      "${preSelectMod} + {Left,Down,Up,Right}" = "bspc node -p {west,south,north,east}";
      "${preSelectMod} + {1-9}" = "bspc node -o 0.{1-9}";
      "${preSelectMod} + space" = "bspc node -p cancel";

      "XF86MonBrightness{Down,Up}" = "light -{U,A} 5";
      "XF86Audio{LowerVolume,RaiseVolume,Mute}" = "amixer set Master {5%-,5%+,toggle}";
      "XF86Audio{Prev,Play,Next}" = "playerctl {previous,play-pause,next}";
    };
  };
}
