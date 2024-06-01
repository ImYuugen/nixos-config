let
  common = import ../common;
in
[
  ./ags
  ./hyprlock
  ./kanshi
  ./launcher
  ./mako
  #  ./waybar
] ++ common
