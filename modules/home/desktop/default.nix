{ lib, ... }:

{
  wayland = import ./wayland { inherit lib; };
}
