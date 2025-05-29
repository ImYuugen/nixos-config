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
    ./locales.nix # Move to base profile
    ./nix.nix # Move to base profile
    ./users.nix

    self.nixosModules.audio
    self.nixosModules.gaming.dualsense
    self.nixosModules.gaming.steam
    self.nixosModules.hardware.bluetooth
    self.nixosModules.hardware.disks
    self.nixosModules.networking.networkmanager
    self.nixosModules.power.auto-cpufreq
    self.nixosModules.security.doas

    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  modules = {
    audio.pipewire.enable = true;
    gaming.dualsense.enable = true;
    gaming.steam.enable = true;
    hardware = {
      bluetooth.enable = true;
      disks.enable = true;
    };
    networking.networkmanager.enable = true;
    power.auto-cpufreq.enable = true;
    security.doas.enable = true;
  };

  system.stateVersion = "23.11";
}
