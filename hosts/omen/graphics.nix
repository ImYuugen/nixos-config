{ config, pkgsSet, ... }:

{
  boot = {
    blacklistedKernelModules = [ "nouveau" ];
    kernelModules = [
      "nvidia"
      "nvidia_drm"
    ];
  };

  environment.systemPackages = with pkgsSet.stable; [
    mesa
    nvtopPackages.full
    vulkan-tools
  ];

  hardware = {
    amdgpu = {
      amdvlk = {
        enable = true;
        support32Bit.enable = true;
        supportExperimental.enable = true;
      };
    };
    graphics = {
      enable = true;
      enable32Bit = true;
      # Video Acceleration stuff
      extraPackages = with pkgsSet.stable; [
        libva-vdpau-driver
        nvidia-vaapi-driver
      ];
      extraPackages32 = with pkgsSet.stable.driversi686Linux; [
        libva-vdpau-driver
      ];
    };
    nvidia = {
      dynamicBoost.enable = true;
      modesetting.enable = true;
      nvidiaSettings = true;
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      powerManagement = {
        enable = true;
        finegrained = true;
      };
      prime = {
        amdgpuBusId = "PCI:7:0:0";
        nvidiaBusId = "PCI:1:0:0";
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        reverseSync.enable = true;
      };
    };
  };

  services.xserver.videoDrivers = [
    "nvidia"
  ];
}
