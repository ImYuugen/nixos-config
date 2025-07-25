{ pkgsSet, self, ... }:

{
  imports = [
    self.nixosModules.plymouth
  ];

  boot = {
    kernelParams = [
      "usbcore.autosuspend=-1"
      "kvm.enable_virt_at_load=0"
    ];
    kernelPackages = pkgsSet.unstable.linuxPackages_latest;
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

  # Slows down boot
  systemd.services.NetworkManager-wait-online.enable = false;
}
