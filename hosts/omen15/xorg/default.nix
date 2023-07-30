{ config, pkgs, user, inputs, lib, ... }:

{
  imports = [
    ../hardware-configuration.nix
    ../../../modules/fonts
    ../../../modules/desktop/bspwm
    
    ../../../modules/programs/common/games

    inputs.nixos-hardware.nixosModules.common-cpu-amd
    #inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  users = {
    mutableUsers = true;
    users."${user}" = {
      shell = pkgs.fish;
      isNormalUser = true;
      extraGroups = [ "wheel" "video" "audio" ];
      packages = with pkgs; [
      ];
    };
  };

  programs.fish.enable = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "nvidia" ];
    blacklistedKernelModules = [ "nouveau" ];
    kernelParams = [ "quiet" "splash" "nvidia-drm.modeset=1" ];
    consoleLogLevel = 0;
    bootspec.enable = true;
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        useOSProber = true;
        efiSupport = true;
        configurationLimit = 10;
        default = "saved";
      };
      systemd-boot.enable = false;#(lib.mkIf config.boot.lanzaboote.enable) {
        #enable = lib.mkForce false;
        #consoleMode = "auto";
      #};
      efi.canTouchEfiVariables = true;
      #lanzaboote = {
      #  enable = false;
      #  pkiBundle = "/etc/secureboot";
      #};
    };
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = [ pkgs.fcitx5-mozc ];
  };

  environment = {
    systemPackages = with pkgs; [
      libnotify xclip xorg.xrandr arandr cinnamon.nemo
      polkit_gnome networkmanagerapplet xorg.xev
      alsa-lib alsa-utils flac pulsemixer linux-firmware
      sshpass pkgs.rust-bin.stable.latest.default lxappearance
      imagemagick flameshot playerctl iwd alsa-lib nvidia-vaapi-driver
      libva libva-utils mesa linuxHeaders xorg.xinit

      galculator libreoffice
    ];
  };

  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      displayManager = {
        lightdm.enable = true;
      };
      layout = "us,fr";
      libinput = {
        enable = true;
        touchpad = {
          naturalScrolling = true;
        };
        mouse = {
          accelProfile = "flat";
        };
      };
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

  hardware = {
    nvidia = {
      nvidiaSettings = true;
      modesetting.enable = true;
      prime = {
        offload.enable = true;
        amdgpuBusId = "PCI:7:0:0";
        nvidiaBusId = "PCI:1:0:0";
        reverseSync.enable = true;
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
    opentabletdriver = {
      enable = true;
    };
    logitech = {
      wireless.enable = true;
      wireless.enableGraphical = true;
    };
  };

  specialisation = {
    external-display.configuration = {
      system.nixos.tags = [ "external-display" ];
      hardware.nvidia = {
        prime.offload.enable = lib.mkForce false;
        #powerManagement.enable = lib.mkForce false;
      };
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
