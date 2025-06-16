{ pkgs, self, ... }:

{
  imports = [
    self.homeManagerModules.programs.editors.emacs
  ];

  modules.programs.editors.emacs = {
    terminal = true;
    daemon = true;
    waylandPure = true;
  };

  home.packages = with pkgs; [
    wakatime-cli
  ];

  # Enable once config is finished
  # xdg.configFile."emacs" = {
  #   source = ./config/emacs;
  #   recursive = true;
  # };
}
