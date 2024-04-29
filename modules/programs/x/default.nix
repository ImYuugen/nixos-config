let
  common = import ../common;
  bspwm = import ./bspwm;
in
[] ++ bspwm ++ common
