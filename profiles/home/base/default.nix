{ lib, self, ... }:

{
  key = ./.;

  imports = with self.homeManagerModules; [
    programs.direnv
    programs.editors.helix
    programs.shells.bash
    programs.shells.zsh
    programs.shells.cli.bat
    programs.shells.cli.btop
    programs.shells.cli.eza
    programs.shells.cli.fzf
    programs.shells.cli.zoxide
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
        cli = {
          bat.enable = lib.mkDefault true;
          btop.enable = lib.mkDefault true;
          eza.enable = lib.mkDefault true;
          fzf.enable = lib.mkDefault true;
          zoxide.enable = lib.mkDefault true;
        };
        zsh = {
          enable = lib.mkDefault true;
          viBindings = lib.mkDefault true;
          withOhMyZsh = lib.mkDefault true;
        };
      };
    };
  };

  programs = {
    ripgrep.enable = lib.mkDefault true;
  };

  xdg.enable = lib.mkDefault true;
}
