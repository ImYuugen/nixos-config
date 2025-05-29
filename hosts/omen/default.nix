{
  config,
  inputs,
  lib,
  pkgsSet,
  self,
  ...
}:

{
  imports = [
    ./boot.nix
    ./disks.nix
    ./graphics.nix
    ./hardware-config.nix
    ./users.nix

    self.nixosModules.profiles.base

    self.nixosModules.gaming.dualsense
    self.nixosModules.gaming.gamemode
    self.nixosModules.gaming.steam

    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  modules = {
    gaming = {
      dualsense.enable = true;
      gamemode.enable = true;
      steam.enable = true;
    };
  };

  system.stateVersion = "23.11";
}
