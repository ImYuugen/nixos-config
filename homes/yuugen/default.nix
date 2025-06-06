{ self, ... }:

{
  imports = with self.homeManagerModules; [
    profiles.base
    profiles.base-graphical
    profiles.desktop.wayland.hyprland

    programs.shells.fish
    programs.terminals.wezterm

    ./git.nix
    ./hyprland.nix
    ./starship.nix
  ];

  modules = {
    programs = {
      shells = {
        fish = {
          enable = true;
          viBindings = true;
        };
      };
      terminals.wezterm.enable = true;
    };
  };
}
