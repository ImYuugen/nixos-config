{ ... }:

{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/11945be8-e970-496b-8fad-806249b09379";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/9DC3-35D5";
      fsType = "vfat";
    };
  };
  boot.initrd.luks.devices."luks-c939d0e2-c041-4aef-8f59-8cad5f1f7eae".device = "/dev/disk/by-uuid/c939d0e2-c041-4aef-8f59-8cad5f1f7eae";

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];
}
