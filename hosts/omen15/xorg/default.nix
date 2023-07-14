{ config, pkgs, user, inputs, lib, ... }:

{
  imports = [
    ../hardware-configuration.nix
    ../../../modules/fonts
    ../../../modules/desktop/bspwm
     
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  users = {
    mutableUsers = true;
    users.{user} = {
      shell = pkgs.fish;
      isNormalUser = true;
      extraGroups = [ "wheel" "video" "audio" ];
      packages = with pkgs; [
      ];
    };
  };

  programs.fish.enable = true;

  boot = {
    kernelModules = [ "amdgpu" "nvidia" ];
    kernelParams = [ "quiet" "splash" "nvidia-drm.modeset=1" ];
    consoleLogLevel = 0;
    bootspec.enable = true;
    loader = {
      #grub = {
      #  enable = false;
      #  device = "nodev";
      #  useOSProber = true;
      #  efiSupport = true;
      #};
      systemd-boot = (lib.mkIf config.boot.lanzaboote.enable) {
        enable = lib.mkForce false;
        consoleMode = "auto";
      };
      efi.canTouchEfiVariables = true;
      lanzaboote = {
        enable = false;
        pkiBundle = "/etc/secureboot";
      };
    };
  };

  i18n.inputMethod = {

  };

  environment = {
    systemPackages = with pkgs; [
      libnotify xclip xorg.xrandr cinnamon.nemo
      polkit_gnome networkmanagerapplet xorg.xev
      alsa-lib alsa-utils flac pulsemixer linux-firmware
      sshpass pkgs.rust-bin.stable.latest.default lxappearance
      imagemagick flameshot
    ];
  };

  services = {
    xserver.libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };
    dbus.packages = [ pkgs.gcr ];
    getty.autologinUser = "${user}";
    gvfs.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  security.polkit.enable = true;
  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraConfig = ''
      permit nopass :wheel
    '';
  };
}
