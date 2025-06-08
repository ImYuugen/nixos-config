{ self, ... }:

{
  imports = with self.homeManagerModules; [
    profiles.base
    profiles.base-graphical
    profiles.desktop.wayland.hyprland

    programs.communications.discord
    programs.shells.fish
    programs.media.spotify
    programs.terminals.wezterm

    ./email.nix
    ./git.nix
    ./hyprland.nix
    ./starship.nix
  ];

  modules = {
    programs = {
      communications.discord.enable = true;
      media.spotify.enable = true;
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
