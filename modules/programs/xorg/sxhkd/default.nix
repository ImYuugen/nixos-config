{ config, pkgs, lib, ... }:
{
  config = lib.mkIf (config.xsession.enable) {
    services.sxhkd = {
      enable = true;
      extraConfig = ''
        super + {_,shift + }Return
          alacritty {_,class='termfloat'}

        super + {_,shift + }q
          bspc node -{c,k}


        #=-=-= Apps =-=-=#

        super + d
          rofi -show drun

        super{_, + shift} + e
          {nemo, alacritty; joshuto}
        
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

        ### RESIZE MODE ###

        super + r : {Left,Down,Up,Right}
          STEP=20; SELECTION={1,2,3,4}; \
          bspc node -z $(echo "left -$STEP 0,bottom 0 $STEP,top 0 -$STEP,right $STEP 0" | cut -d',' -f$SELECTION) || \
          bspc node -z $(echo "right -$STEP 0,top 0 $STEP,bottom 0 -$STEP,left $STEP 0" | cut -d',' -f$SELECTION)


        super + r : {h,j,k,l}
          STEP=20; SELECTION={1,2,3,4}; \
          bspc node -z $(echo "left -$STEP 0,bottom 0 $STEP,top 0 -$STEP,right $STEP 0" | cut -d',' -f$SELECTION) || \
          bspc node -z $(echo "right -$STEP 0,top 0 $STEP,bottom 0 -$STEP,left $STEP 0" | cut -d',' -f$SELECTION)

        ###     END     ###

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
