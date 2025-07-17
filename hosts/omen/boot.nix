{ self, ... }:

{
  imports = [
    self.nixosModules.plymouth
  ];

  modules.plymouth.enable = true;

  boot = {
    kernelParams = [
      "usbcore.autosuspend=-1"
      "kvm.enable_virt_at_load=0"
    ];
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
