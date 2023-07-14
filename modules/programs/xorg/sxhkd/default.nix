{ config, pkgs, lib, ... }:
{
  config = lib.mkIf (config.xsession.enable) {
    services.sxhkd = {
      enable = true;
    };
  };

  home.file.".config/sxhkd/sxhkdrc".text = ''
    super + Return
      alacritty

    super + shift + Return
      alacritty --class='termfloat'

    super + shift + {e,r}
      {promt "Wanna quit ?" "bspc quit", bspc wm -r}

    super + {_,shift + }q
      bspc node -{c,k}

    super + d
      rofi -show

    # monocle
    super + m
      bspc desktop -l next

    # swap current and biggest window
    super + g
      bspc node -s biggest.window

    super + {t,shift + t,@space,f}
      bspc node -t {tiled,pseudo_tiled,floating,fullscreen}

    super + ctrl + {m,x,y,z}
      bspc node -g {marked,locked,sticky,private}


    super + {_,shift + }{h,j,k,l}
      bspc node -{f,s} {west,south,north,east}

    super + {p,b,comma,period}
      bspc node -f @{parent,brother,first,second}

    super + {_,shift + }c
      bspc node -f {next,prev}.local.!hidden.window

    # next/prev desktop
    super + bracket{left,right}
      bspc desktop -f {prev,next}.local

    super + {grave,Tab}
      bspc {node,desktop} -f last

    super + {_,shift + }{1-9,0}
      bspc {desktop -f,node -f} '^{1-9,10}'

    # expand
    super + alt + {h,j,k,l}
      bspc node -z {left -20 0, bottom 0 20, top 0 -20, right 20 0}

    # shrink
    super + alt + shift + {h,j,k,l}
      bspc node -z {right -20 0, bottom 0 -20, top 0 20, left -20 0}

    super + {Left,Down,Up,Right}
      bspc node -v {-20 0, 0 20, 0 -20, 20 0}


    ### APPS ###
    alt + shift + e
      nemo

    alt + shift + w
      firefox

    alt + shift + g
      steam

    alt + shift + d
      discord

    alt + shift + m
      spotify
  '';
}
