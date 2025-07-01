{ inputs, pkgs, ... }:

{
  imports = [
    inputs.chaotic.nixosModules.nyx-cache
    inputs.chaotic.nixosModules.nyx-overlay
    inputs.chaotic.nixosModules.nyx-registry
  ];
  boot = {
    kernelParams = [
      "usbcore.autosuspend=-1"
      "kvm.enable_virt_at_load=0"
    ];
    # kernelPackages = pkgsSet.unstable.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_cachyos;
    supportedFilesystems = {
      ntfs = true;
    };
    loader = {
      systemd-boot.enable = false;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
      efi.canTouchEfiVariables = true;
    };
  };
}
