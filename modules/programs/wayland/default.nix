let
  common = import ../common;
in
[
  ./ags
  ./launcher
  ./mako
  ./waybar
] ++ common
