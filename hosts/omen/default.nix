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
    profiles.cachy
    profiles.desktop.wayland.hyprland

    dev.arduino
    gaming.dualsense
    gaming.gamecube
    gaming.gamemode
    gaming.steam
    networking.protonvpn
    virtualisation.docker
    virtualisation.libvirtd

    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  modules = {
    dev = {
      arduino.enable = true;
    };
    networking.protonvpn = {
      enable = true;
      autostart = false;
      interface = {
        name = "protonvpn-FR";
        ip = "10.2.0.2/32";
        port = 51820;
        privateKeyFile = "/root/secrets/protonvpn-FR-pkey";
        dns = {
          enable = true;
          ip = "10.2.0.1";
        };
      };
      endpoint = {
        publicKey = "zeGY3uQTDqTiaxp6vGqFzXck1TPNnzY+JZ2iNI2BrRU=";
        ip = "146.70.194.98";
        port = 51820;
      };
    };
    gaming = {
      dualsense.enable = true;
      gamecube = {
        enable = true;
        overclockGCC = true;
      };
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
