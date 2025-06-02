{ self, ... }:

{
  key = ./.;

  imports = with self.homeManagerModules; [
    programs.editors.helix
    programs.shells.bash
    programs.shells.zsh
    programs.shells.cli.fzf
    programs.shells.cli.starship
    programs.shells.cli.zoxide
  ];

  modules = {
    programs = {
      editors.helix.enable = true;
      shells = {
        bash = {
          enable = true;
          viBindings = true;
        };
        cli = {
          fzf.enable = true;
          starship.enable = true;
          zoxide.enable = true;
        };
        zsh = {
          enable = true;
          viBindings = true;
          withOhMyZsh = true;
        };
      };
    };
  };
}
