{ config, pkgs, lib, ... }:
{
  config = lib.mkIf (config.xsession.enable) {
    services.sxhkd = {
      enable = true;
      extraConfig = ''
        super + {_,shift + }Return
          alacritty {_,--class termfloat}

        super + {_,shift + }q
          bspc node -{c,k}

        #reload sxhkd
        super + Escape
          pkill -USR1 -x sxhkd

        #lock screen
        super + shift + l
          i3lock-fancy

        #=-=-= Apps =-=-=#

        super + {d,r}
          rofi -modi "run,drun" -show {drun,run}

        super{_, + shift} + e
          {nemo, alacritty --command joshuto}
        
        alt + shift + w
          nvidia-offload firefox

        alt + shift + d
          discord

        alt + shift + s
          steam

        #=-=-= /Apps =-=-=#


        #=-=-= Windows/Desktops =-=-=#

        super + {_,shift + }{1-9,0}
          bspc {desktop -f,node -d} '^{1-9,10}'

        super + shift + {a,d}
          bspc node @/ -C {backward,forward}

        super + {t,f,m}
          bspc node -t {tiled,floating,fullscreen}

        #focus node in direction
        super + {h,j,k,l}
          bspc node -f {west,south,north,east}
        super + {Left,Down,Up,Right}
          bspc node -f {west,south,north,east}

        #focus last node/desktop
        super + {Tab}
          bspc {node} -f last
         
        #preselect direction
        ctrl + alt + {h,j,k,l}
          bspc node -p {west,south,north,east}
        ctrl + alt + {Left,Down,Up,Right}
          bspc node -p {west,south,north,east}

        #preselect ratio
        ctrl + alt + {1-9}
          bspc node -o 0.{1-9}

        #cancel preselection
        ctrl + alt + space
          bspc node -p cancel


        #=-=-= /Windows/Desktops =-=-=#



        #=-=-= Function Keys =-=-=#

        XF86MonBrightness{Down,Up}
          light -{U,A} 5

        XF86Audio{LowerVolume,RaiseVolume,Mute}
          amixer set Master {5%-,5%+,toggle}

        XF86Audio{Prev,Play,Next}
          playerctl {previous,play-pause,next}

        #=-=-= /Function Keys =-=-=#
      '';
    };
  };
}
