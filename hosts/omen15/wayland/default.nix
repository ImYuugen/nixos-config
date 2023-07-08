{ config, pkgs, user, inputs, lib, ... }:
{
  imports = [
    ../hardware-configuration.nix
    ../../../modules/fonts

    #../../../modules/desktop/sway
    ../../../modules/desktop/hyprland

    ../../../modules/programs/common/games

    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  users = {
    mutableUsers = true;
    users.${user} = {
      shell = pkgs.fish;
      isNormalUser = true;
      extraGroups = [ "wheel" "video" "audio" ];
      packages = with pkgs; [
        thunderbird
      ];
    };
  };
  programs.fish.enable = true;

  boot = {
    kernelModules = [ "amdgpu" "nvidia" ];
    kernelParams = [
      "quiet"
      "splash"
      "nvidia-drm.modeset=1"
    ];
    consoleLogLevel = 0;
    loader = {
      grub = {
        enable = false;
        device = "nodev";
        useOSProber = true;
        efiSupport = true;
      };
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
      };
    };
    #lanzaboote = {
    #  enable = true;
    #};
  };

  environment = {
    systemPackages = with pkgs; [
      ## Wayland stuff
      xwayland wl-clipboard wlr-randr wayland wayland-scanner
      wayland-utils egl-wayland wayland-protocols glfw-wayland
      qt6.qtwayland wev sway-contrib.grimshot wayfire wlroots swayidle
     
      libsForQt5.qt5ct libsForQt5.qt5.qtwayland lxappearance
      nvidia-vaapi-driver libva mesa linuxHeaders

      flameshot grim slurp pulsemixer alsa-lib alsa-utils iwd polkit_gnome
      rust-bin.stable.latest.default libnotify playerctl krita
    ];
  };

  services = {
    xserver = {
      videoDrivers = [ "amdgpu" "nvidia" ];
    };

    dbus.packages = [ pkgs.gcr ];
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      pulse.enable = true;
    };
  };

  hardware = {
    nvidia.modesetting.enable = true;
    nvidia.prime = {
      offload.enable = true;
      amdgpuBusId = "PCI:7:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
      enable = true;
      extraPackages = [ pkgs.mesa.drivers ];
    };
    opentabletdriver = {
      enable = true;
    };
  };

  systemd = {
    user.services.polkit-gnome-authentification-agent-1 = {
      description = "polkit-gnome-authentification-agent-1";
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

  security = {
    polkit.enable = true;
    sudo = {
      enable = false;
      extraConfig = ''
        ${user} ALL=(ALL) NOPASSWD:ALL
      '';
    };
    doas = {
      enable = true;
      extraConfig = ''
        permit nopass :wheel
      '';
    };
  };
}
