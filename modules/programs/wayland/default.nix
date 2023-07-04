let
  common = import ../common;
in [
  ./launcher
  ./mpv
  ./mako
] ++ common
