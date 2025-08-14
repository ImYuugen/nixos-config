{ self, ... }:

{
  imports = [
    self.homeManagerModules.programs.cli.fastfetch
  ];

  modules.programs.cli.fastfetch.enable = true;

  xdg.configFile."fastfetch/config.jsonc".source = ./config/fastfetch.jsonc;
}
