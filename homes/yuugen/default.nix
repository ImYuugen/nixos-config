{ pkgs, self, ... }:

{
  imports = with self.homeManagerModules; [
    profiles.base
    profiles.base-graphical
    profiles.desktop.wayland.hyprland

    desktop.fcitx5
    programs.communications.discord
    programs.editors.helix
    programs.media.spotify
    programs.production.obs
    programs.shells.fish
    services.easyeffects

    ./emacs.nix
    ./email.nix
    ./gaming.nix
    ./git.nix
    ./graphical/hyprland.nix
    ./graphical/rofi.nix
    ./graphical/wezterm.nix
    ./starship.nix
  ];

  modules = {
    desktop.fcitx5 = {
      autoLaunch = true;
      enable = true;
    };
    programs = {
      communications.discord.enable = true;
      editors.helix.withWakaTime = true;
      media.spotify.enable = true;
      production.obs.enable = true;
      shells = {
        fish = {
          enable = true;
          viBindings = true;
        };
      };
    };
    services = {
      easyeffects = {
        enable = true;
        withDefaultPresets = true;
      };
    };
  };

  # TODO: Module
  home.packages = with pkgs; [
    protonup-qt
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.kio-fuse
    kdePackages.kio-extras
  ];
}
