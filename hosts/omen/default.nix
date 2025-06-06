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
    self.nixosModules.profiles.base-graphical

    self.nixosModules.gaming.dualsense
    self.nixosModules.gaming.gamemode
    self.nixosModules.gaming.steam
    self.nixosModules.virtualisation.docker
    self.nixosModules.virtualisation.libvirtd

    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  modules = {
    gaming = {
      dualsense.enable = true;
      gamemode.enable = true;
      steam = {
        enable = true;
        withProtonGE = true;
        withGamescopeSession = true;
      };
    };
    virtualisation = {
      docker.enable = true;
      libvirtd.enable = true;
    };
  };

  networking.hostName = "omen";

  programs.steam.gamescopeSession.args = lib.mkOptionDefault [
    "-W 1920"
    "-H 1080"
    "-r 144"
  ];

  system.stateVersion = "23.11";
}
