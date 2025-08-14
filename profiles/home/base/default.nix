{ lib, self, ... }:

{
  key = ./.;

  imports = with self.homeManagerModules; [
    programs.cli.bat
    programs.cli.btop
    programs.cli.eza
    programs.cli.fzf
    programs.cli.zoxide
    programs.direnv
    programs.editors.helix
    programs.shells.bash
  ];

  modules = {
    programs = {
      direnv = {
        enable = lib.mkDefault true;
        withMise = lib.mkDefault true;
      };
      editors.helix.enable = lib.mkDefault true;
      shells = {
        bash = {
          enable = lib.mkDefault true;
          viBindings = lib.mkDefault true;
        };
      };
      cli = {
        bat.enable = lib.mkDefault true;
        btop.enable = lib.mkDefault true;
        eza.enable = lib.mkDefault true;
        fzf.enable = lib.mkDefault true;
        zoxide.enable = lib.mkDefault true;
      };
    };
  };

  programs = {
    ripgrep.enable = lib.mkDefault true;
  };

  xdg.enable = lib.mkDefault true;
}
