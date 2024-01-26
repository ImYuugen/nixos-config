let
  common = import ../common;
in
[
  ./launcher
  ./mako
  ./waybar
] ++ common
