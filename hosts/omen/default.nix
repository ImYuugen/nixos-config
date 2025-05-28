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

    self.nixosModules.audio
    self.nixosModules.hardware.bluetooth
    self.nixosModules.networking.networkmanager
    self.nixosModules.security.doas

    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  modules.audio.pipewire.enable = true;
  modules.hardware.bluetooth.enable = true;
  modules.networking.networkmanager.enable = true;
  modules.security.doas.enable = true;

  system.stateVersion = "23.11";
}
