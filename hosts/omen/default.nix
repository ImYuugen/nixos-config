{
  inputs,
  lib,
  self,
  ...
}:

{
  imports = with self.nixosModules; [
    ./boot.nix
    ./disks.nix
    ./graphics.nix
    ./hardware-config.nix
    ./users.nix

    profiles.base
    profiles.base-graphical
    profiles.desktop.wayland.hyprland

    gaming.dualsense
    gaming.gamemode
    gaming.steam
    virtualisation.docker
    virtualisation.libvirtd

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
