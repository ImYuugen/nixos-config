{
  config,
  lib,
  pkgsSet,
  ...
}:

let
  cfg = config.modules.virtualisation.libvirtd;
in
{
  options.modules.virtualisation.libvirtd = {
    enable = lib.mkEnableOption "Libvirtd";
    qemu.enable = lib.mkOptionDefault true;
    virt-manager.enable = lib.mkOptionDefault true;
  };

  config = lib.mkIf cfg.enable {
    programs.virt-manager.enable = true;
    virtualisation.libvirtd = {
      enable = lib.mkDefault true;
      onBoot = lib.mkDefault "ignore";
      qemu = {
        swtpm.enable = lib.mkDefault true;
        ovmf = {
          enable = lib.mkDefault true;
          packages = lib.mkDefault [ pkgsSet.stable.OVMFFull.fd ];
        };
      };
    };
  };
}
