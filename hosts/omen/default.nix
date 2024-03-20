{ self, system, lib, pkgs, inputs, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/fonts
    (import ../../modules/programs/common/gaming/steam.nix)

    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  networking = {
    hostName = "omen-nixos";
    networkmanager.enable = true;
    networkmanager.wifi.backend = "iwd";
    wireless.iwd.enable = true;
  };

  virtualisation = {
    docker = {
      enable = true;
    };
  };

  users = {
    mutableUsers = true;
    users.${user} = {
      shell = pkgs.fish;
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker" ];
    };
  };
  programs.dconf.enable = true;
  programs.fish.enable = true;

  boot = {
    kernelModules = [ "nvidia" ];
    kernelParams = [
      "nvidia-drm.modeset=1"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" ];

    bootspec.enable = true;

    loader = {
      grub = {
        enable = lib.mkForce false;
        device = "nodev";
        useOSProber = true;
        efiSupport = true;
      };
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };

  environment.systemPackages = with pkgs; [
    alsa-lib alsa-utils glib
    libnotify linux-firmware linuxHeaders
    xdg-utils pciutils killall pkg-config
    zip unzip p7zip rar
 
    sbctl

    libva libva-utils mesa

    # Nvidia
    nvidia-vaapi-driver
    # Amd
    amdvlk
  ];

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    nvidia = {
      nvidiaSettings = true;
      modesetting.enable = true;
      prime = {
        offload.enable = true;
        amdgpuBusId = "PCI:7:0:0";
        nvidiaBusId = "PCI:1:0:0";
        reverseSync.enable = true;
      };
      powerManagement.enable = true;
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        libva vaapiVdpau mesa.drivers
      ];
    };
    opentabletdriver.enable = true;
  };

  powerManagement.enable = true;
  powerManagement.powertop.enable = true;
  services = {
    auto-cpufreq.enable = true;

    dbus = {
      enable = true;
      packages = [ pkgs.gcr ];
    };
    openssh.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      pulse.enable = true;
    };

    thermald.enable = true;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_ON_AC = "balance_performance";
        CPU_ENERGY_PERF_ON_BAT = "power";

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        USB_AUTOSUSPEND = 0;
      };
    };

    xserver.videoDrivers = [ "nvidia" ];
  };
}
