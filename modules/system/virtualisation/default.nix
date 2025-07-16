{ lib, ... }:

{
  docker = import ./docker.nix;
  libvirtd = import ./libvirtd.nix;
}
