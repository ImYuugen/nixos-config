{ self, config, inputs, lib, pkgs, system, unstable, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/fonts
    (import ../../modules/programs/common/gaming/syswide.nix)

    inputs.nixos-hardware.nixosModules.common-cpu-amd
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
    kernelModules = [ "nvidia" "nvidia_drm" ];
    kernelParams = [
      "usbcore.autosuspend=-1"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" ];
    initrd.verbose = false;
    consoleLogLevel = 0;

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
    alsa-lib
    alsa-utils
    glib
    libnotify
    linux-firmware
    linuxHeaders
    xdg-utils
    pciutils
    killall
    pkg-config
    zip
    unzip
    p7zip
    rar

    sbctl
    acpi

    libva
    libva-utils
    mesa

    # Graphics stuff
    shaderc
    directx-shader-compiler
    ocl-icd
    libGL
    vulkan-tools
    vulkan-tools-lunarg
    vulkan-headers
    vulkan-loader
    vulkan-validation-layers

    nvtop
    # Nvidia
    nvidia-vaapi-driver
    vaapiVdpau
    # Amd
    amdvlk
  ];

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    nvidia = {
      # Uncomment when open is no longer broken
      #      open = true;
      open = false;
      nvidiaSettings = true;
      modesetting.enable = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        reverseSync.enable = true;
        amdgpuBusId = "PCI:7:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
      powerManagement = {
        enable = true;
      };
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        libva
        vaapiVdpau
        mesa.drivers
      ];
    };
    opentabletdriver.enable = true;
  };

  powerManagement.enable = true;
  services = {
    auto-cpufreq = {
      enable = false;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };

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
        USB_AUTOSUSPEND = 0;
      };
    };

    xserver.videoDrivers = [ "nvidia" ];
  };
}
