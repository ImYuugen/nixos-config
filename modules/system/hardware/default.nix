{ lib, ... }:

{
  bluetooth = import ./bluetooth.nix;
  disks = import ./disks.nix;
}
