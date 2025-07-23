{ self, ... }:

{
  imports = [
    self.homeManagerModules.programs.terminals.wezterm
  ];

  modules.programs.terminals.wezterm.enable = true;

  xdg.configFile = {
    "wezterm" = {
      source = ../config/wezterm;
      recursive = true;
    };
  };
}
