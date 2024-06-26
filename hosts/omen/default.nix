{ inputs
, pkgsSet
, ...
}:
let
  pkgs = pkgsSet.stable;
in
{
  imports = [
    ../shared/fonts.nix
    ../shared/gaming.nix
    ../shared/i18n.nix
    ../shared/nix.nix
    ../shared # TODO: Modularize moar

    ./hardware.nix
    ./packages.nix
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  boot = {
    kernelModules = [
      "nvidia"
      "nvidia_drm"
    ];
    kernelParams = [
      "usbcore.autosuspend=-1"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "nfts" ];
    bootspec.enableValidation = true;
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  hardware = {
    bluetooth = {
      enable = true;
    };
    nvidia = {
      open = false;
      nvidiaSettings = true;
      modesetting.enable = true;
      dynamicBoost.enable = true;
      powerManagement = {
        enable = true;
      };
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        reverseSync.enable = true;
        amdgpuBusId = "PCI:7:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        libva
        vaapiVdpau
      ];
    };
    opentabletdriver = {
      enable = true;
    };
  };

  networking = {
    hostName = "omen";
    networkmanager = {
      enable = true;
    };
  };

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  programs = {
    fish.enable = true;
    light.enable = true;
  };

  services = {
    auto-cpufreq = {
      enable = true;
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
    xserver.enable = true;
    xserver.videoDrivers = [ "nvidia" ];
    xserver.displayManager.startx.enable = true;
  };

  users.users.yuugen = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "audio" "docker" "networkmanager" "video" "wheel" ];
  };

  virtualisation = {
    docker = {
      enable = true;
    };
  };

  system.stateVersion = "23.11";
}
