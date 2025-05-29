{ pkgsSet, self, ... }:

{
  boot.kernelModules = [
    "nvidia"
    "nvidia_drm"
  ];

  environment.systemPackages = with pkgsSet.stable; [
    mesa
    nvtopPackages.full
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      # Additional vulkan AMD drivers
      # And Video Acceleration stuff
      extraPackages = with pkgsSet.stable; [
        amdvlk
        libva-vdpau-driver
        nvidia-vaapi-driver
      ];
      extraPackages32 = with pkgsSet.stable.driversi686Linux; [
        amdvlk
        libva-vdpau-driver
      ];
    };
    nvidia = {
      dynamicBoost.enable = true;
      modesetting.enable = true;
      nvidiaSettings = true;
      open = true;
      package = self.boot.kernelPackages.nvidiaPackages.latest;
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

  services.xserver.drivers = [ "nvidia" ];
}
