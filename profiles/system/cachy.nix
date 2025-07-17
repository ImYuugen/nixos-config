{
  config,
  inputs,
  lib,
  pkgs,
  self,
  ...
}:

let
  udevRules = [
    (pkgs.writeTextDir "etc/udev/rules.d/30-zram.rules" ''
      ACTION=="change", KERNEL=="zram0", ATTR{initstate}=="1", SYSCTL{vm.swappiness}="150", RUN+="/bin/sh -c 'echo N > /sys/module/zswap/parameters/enabled'"
    '')
    (pkgs.writeTextDir "etc/udev/rules.d/40-hpet-permissions.rules" ''
      KERNEL=="rtc0", GROUP="audio"
      KERNEL=="hpet", GROUP="audio"
    '')
    (pkgs.writeTextDir "etc/udev/rules.d/60-ioschedulers.rules" ''
      ACTION=="add|change", KERNEL=="sd[a-z]*", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"
      ACTION=="add|change", KERNEL=="sd[a-z]*|mmcblk[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="mq-deadline"
      ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="none"
    '')
  ];
in
{
  key = ./cachy.nix;

  imports = [
    inputs.chaotic.nixosModules.nyx-cache
    inputs.chaotic.nixosModules.nyx-overlay
    inputs.chaotic.nixosModules.nyx-registry
    self.nixosModules.gaming.ananicy
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    # CachyOS Settings
    # https://github.com/CachyOS/CachyOS-Settings/blob/master/usr/lib/sysctl.d/99-cachyos-settings.conf
    kernel.sysctl = {
      "vm.swappiness" = 100;
      "vm.vfs_cache_pressure" = 50;
      "vm.dirty_bytes" = 268435456;
      "vm.page-cluster" = 0;
      "vm.dirty_background_bytes" = 67108864;
      "vm.dirty_writeback_centisecs" = 1500;
      "kernel.nmi_watchdog" = 0;
      "kernel.unprivileged_userns_clone" = 1;
      "kernel.printk" = "3 3 3 3";
      "kernel.kptr_restrict" = 2;
      "kernel.kexec_load_disabled" = 1;
      "kernel.split_lock_mitigate" = 0;
      "net.core.netdev_max_backlog" = 4096;
      "fs.file-max" = 2097152;
    };
    extraModprobeConfig = ''
      options nvidia NVreg_UsePageAttributeTable=1 \
        NVreg_InitializeSystemMemoryAllocations=0 \
        NVreg_DynamicPowerManagement=0x02 \
        NVreg_RegistryDwords=RMIntrLockingMode=1
    '';
  };

  # Ananicy in place of gamemode to better mimic CachyOS
  modules.gaming = {
    ananicy.enable = true;
    gamemode.enable = lib.mkForce false;
  };

  services = {
    ananicy.rulesProvider = pkgs.ananicy-rules-cachyos_git;
    scx = {
      enable = true;
      package = pkgs.scx_git.full;
    };
    udev.packages = udevRules;
  };
}
