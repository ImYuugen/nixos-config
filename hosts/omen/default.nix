{
  config,
  lib,
  pkgsSet,
  self,
  ...
}:

{
  imports = [
    ./boot.nix
    ./disks.nix
    ./graphics.nix
    ./hardware-config.nix

    #    self.nixosModules.security.doas
  ];

  #  modules.security.doas.enable = true;

  system.stateVersion = "23.11";
}
