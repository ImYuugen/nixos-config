let 
  common = import ../common;
in [
  ./eww
  ./imgview
  ./launcher
  ./mpv
  ./notice
  ./picom
  ./polybar
  ./sxhkd
] ++ common
