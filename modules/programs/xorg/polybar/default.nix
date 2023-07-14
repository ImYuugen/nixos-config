{ config, pkgs, lib, user, ... }:
{
  environment.systemPackages = [ pkgs.polybarFull ];
}
