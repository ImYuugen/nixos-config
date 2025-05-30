{ lib, ... }:

{
  desktop = import ./desktop { inherit lib; };
}
