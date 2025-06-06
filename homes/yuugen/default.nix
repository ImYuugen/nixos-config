{ self, ... }:

{
  imports = with self.homeManagerModules; [
    profiles.base
    profiles.base-graphical
    profiles.desktop.wayland.hyprland

    programs.terminals.wezterm

    ./git.nix
    ./hyprland.nix
    ./starship.nix
  ];

  modules = {
    programs = {
      terminals.wezterm.enable = true;
    };
  };
}
