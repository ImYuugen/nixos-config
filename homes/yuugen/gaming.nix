{ pkgsSet, self, ... }:

{
  imports = with self.homeManagerModules; [
    gaming.dolphin-emu
    gaming.lutris
    gaming.slippi
  ];

  modules.gaming = {
    dolphin-emu.enable = true;
    lutris = {
      enable = true;
      withIcons = true;
    };
    slippi.enable = true;
  };

  home.packages = [
    pkgsSet.unstable.olympus
  ];
}
