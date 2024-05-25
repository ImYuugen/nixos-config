{ config, lib, pkgs, ... }:

{
  programs.thunderbird = {
    enable = true;
    profiles = {
      "default" = {
        isDefault = true;
        settings = { };
      };
    };
  };
}
