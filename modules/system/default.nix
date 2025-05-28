{ lib, ... }:

{
  security = import ./security { inherit lib; };
}
