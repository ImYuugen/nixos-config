{
  config,
  inputs,
  pkgsSet,
  ...
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
    ../shared/pipewire.nix
    ../shared # TODO: Modularize moar

    ./hardware.nix
    ./packages.nix
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  boot = {
    kernelModules = [
      "nvidia"
      "nvidia_drm"
    ];
    kernelParams = [
      "usbcore.autosuspend=-1"
      "kvm.enable_virt_at_load=0"
    ];
    kernelPackages = pkgsSet.unstable.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" ];
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
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        libva
        vaapiVdpau
      ];
    };
    nvidia = {
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      nvidiaSettings = true;
      modesetting.enable = true;
      dynamicBoost.enable = true;
      powerManagement = {
        enable = true;
        finegrained = true;
      };
      prime = {
        reverseSync.enable = true;
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        amdgpuBusId = "PCI:7:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
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
    nix-ld.enable = true;
    virt-manager.enable = true;
    wireshark = {
      enable = true;
      package = pkgsSet.stable.wireshark;
    };
  };

  services = {
    blueman.enable = true;
    dbus = {
      enable = true;
      packages = [ pkgs.gcr ];
    };
    openssh.enable = true;
    thermald.enable = true;
    tlp = {
      enable = true;
      settings = {
        CPU_DRIVER_OPMODE_ON_AC = "guided";
        CPU_DRIVER_OPMODE_ON_BAT = "passive";
        CPU_SCALING_GOVERNOR_ON_AC = "ondemand";
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_BOOST_ON_AC = "1";
        CPU_BOOST_ON_BAT = "0";
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";
        USB_AUTOSUSPEND = "0";
        USB_ALLOWLIST = "";
        START_CHARGE_THRESH_BAT0 = 70;
        STOP_CHARGE_THRESH_BAT0 = 90;
      };
    };
    udisks2 = {
      enable = true;
    };
    upower.enable = true;
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      # TODO: Only enable on cfg.server == "X"
      displayManager.startx.enable = true;
    };
  };

  users.users.yuugen = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [
      "audio"
      "docker"
      "networkmanager"
      "video"
      "wheel"
      "gamemode"
      "libvirtd"
    ];
  };

  virtualisation = {
    docker = {
      enable = true;
    };
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgsSet.stable.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [ pkgsSet.stable.OVMFFull.fd ];
        };
      };
    };
  };

  system.stateVersion = "23.11";
}
