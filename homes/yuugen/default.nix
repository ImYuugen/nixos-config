{ self, ... }:

{
  imports = with self.homeManagerModules; [
    profiles.base
    profiles.base-graphical
    profiles.desktop.wayland.hyprland

    desktop.fcitx5
    programs.communications.discord
    programs.media.spotify
    programs.production.obs
    programs.shells.fish

    ./email.nix
    ./git.nix
    ./hyprland.nix
    ./starship.nix
    ./wezterm.nix
  ];

  modules = {
    desktop.fcitx5 = {
      autoLaunch = true;
      enable = true;
    };
    programs = {
      communications.discord.enable = true;
      media.spotify.enable = true;
      production.obs.enable = true;
      shells = {
        fish = {
          enable = true;
          viBindings = true;
        };
      };
    };
  };
}
