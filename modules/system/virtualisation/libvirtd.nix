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
    qemu.enable = lib.mkEnableOption "Qemu";
  };

  config = lib.mkIf cfg.enable {
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
