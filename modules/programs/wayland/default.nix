let
  common = import ../common;
in
[
  ./ags
  ./kanshi
  ./launcher
  ./mako
#  ./waybar
] ++ common
