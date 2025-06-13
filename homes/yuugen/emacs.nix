{ self, ... }:

{
  imports = [
    self.homeManagerModules.programs.editors.emacs
  ];

  modules.programs.editors.emacs = {
    terminal = true;
    daemon = true;
  };

  xdg.configFile."emacs" = {
    source = ./config/emacs;
    recursive = true;
  };
}
