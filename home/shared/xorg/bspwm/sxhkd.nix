{
  services.sxhkd = {
    enable = true;
    keybindings = {
      "super + Return" = "$TERMINAL";
      "super + shift + {q,ctrl + k}" = "bspc node -{c,k}";
      "super + shift + x" = "xsecurelock";
      # Apps
      "super + {_,shift + }d" = "rofi -modi \"run,drun\" -show {drun,run}";
      "alt + shift + w" = "firefox";
      # Window/Desktop movement
      "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
      "super + shift + {a,d}" = "bspc node @/ -C {backward,forward}";
      "super + {t,f,m}" = "bspc node -t {tiled,floating,fullscreen}";
      "super + {h,j,k,l}" = "bspc node -f {west,south,north,east}";
      "super + {Left,Down,Up,Right}" = "bspc node -f {west,south,north,east}";
      "super + shift + {h,j,k,l}" = "bspc node -s {west,south,north,east}";
      "super + shift + {Left,Down,Up,Right}" = "bspc node -s {west,south,north,east}";
      "super + {_,shift + }Tab" = "bspc {node,desktop} -f last";
      # Pre selections
      "super + alt + {h,j,k,l}" = "bspc node -p {west,south,north,east}";
      "super + alt + {Left,Down,Up,Right}" = "bspc node -p {west,south,north,east}";
      "super + alt + {1-9}" = "bspc node -o 0.{1-9}";
      "super + alt + space" = "bspc node -p cancel";
      # Media keys
      "XF86MonBrightness{Down,Up}" = "light -{U,A} 5";
      "XF86Audio{LowerVolume,RaiseVolume,Mute}" = "amixer set Master {5%-,5%+,toggle}";
      "XF86Audio{Prev,Play,Next}" = "playerctl {previous,play-pause,next}";
    };
  };
}
