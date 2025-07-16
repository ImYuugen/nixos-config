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
    "/mnt/shared" = {
      device = "/dev/disk/by-uuid/EE8C040B8C03CCD1";
      fsType = "ntfs";
      # Authorize for wheel group
      options = [
        "defaults"
        "gid=1"
        "umask=000"
      ];
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
