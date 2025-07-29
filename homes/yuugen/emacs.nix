{ pkgs, self, ... }:

{
  imports = [
    self.homeManagerModules.programs.editors.emacs
  ];

  modules.programs.editors.emacs = {
    enable = true;
    terminal = true;
    doom = {
      enable = true;
      configDir = ./config/doom;
    };
  };

  home.packages = with pkgs; [
    wakatime-cli
    delta
  ];
}
