{
  services.sxhkd = {
    enable = true;
    keybindings = {
      "super + Return" = "$TERMINAL";
      "super + {_,shift + }q" = "bspc node -{c,k}";
      "super + shift + x" = "xscreensaver";
      # Apps
      "super + {_,shift + }d" = "rofi -modi \"run,drun\" -show {drun,run}";
      "alt + shift + w" = "firefox";
      # Window/Desktop movement
      "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
      "super + shift + {a,d}" = "bspc node @/ -C {backward,forward}";
      "super + {t,f,m}" = "bspc node -t {tiled,floating,fullscreen}";
      "super + {h,j,k,l}" = "bspc node -f {west,south,north,east}";
      "super + {Left,Down,Up,Right}" = "bspc node -f {west,south,north,east}";
      "super + Tab" = "bspc node -f last";
      # Pre selections
      "ctrl + alt + {h,j,k,l}" = "bspc node -p {west,south,north,east}";
      "ctrl + alt + {Left,Down,Up,Right}" = "bspc node -p {west,south,north,east}";
      "ctrl + alt + {1,9}" = "bspc node -o 0.{1-9}";
      "ctrl + alt + Space" = "bspc node -p cancel";
      # Media keys
      "XF86MonBrightness{Down,Up}" = "light -{U,A} 5";
      "XF86Audio{LowerVolume,RaiseVolume,Mute}" = "amixer set Master {5%-,5%+,toggle}";
      "XF86Audio{Prev,Play,Next}" = "playerctl {previous,play-pause,next}";
    };
  };
}
