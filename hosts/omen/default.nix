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
    ./vhdl.nix
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
    dconf.enable = true;
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
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
          # balance_power = 8, power = 15
          energy_perf_bias = "10";
          scaling_min_freq = 400000;
          scaling_max_freq = 3000000;
        };
        charger = {
          governor = "balanced";
          turbo = "auto";
          energy_perf_bias = "balance_performance";
        };
      };
    };
    blueman.enable = true;
    dbus = {
      enable = true;
      packages = [ pkgs.gcr ];
    };
    openssh.enable = true;
    thermald.enable = true;
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
