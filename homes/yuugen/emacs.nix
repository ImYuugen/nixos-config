{ pkgs, self, ... }:

{
  imports = [
    self.homeManagerModules.programs.editors.emacs
  ];

  modules.programs.editors.emacs = {
    terminal = true;
    daemon = true;
    waylandPure = true;
    installOrgDeps = true;
    doom = {
      enable = true;
      configDir = ./config/doom;
    };
  };

  home.packages = with pkgs; [
    wakatime-cli
    delta
  ];

  # Enable once config is finished
  # xdg.configFile."emacs" = {
  #   source = ./config/emacs;
  #   recursive = true;
  # };
}
