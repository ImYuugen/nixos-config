{
  pkgs,
  self,
  ...
}:

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
    ./fastfetch.nix
    ./gaming.nix
    ./git.nix
    ./hyprland.nix
    ./theming.nix
    ./rofi.nix
    ./wezterm.nix
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
          fastfetchGreet = true;
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

  home.sessionVariables.EXPLORER = "nemo";

  # TODO: Module (Like fr this is getting out of hand)
  home.packages = with pkgs; [
    krita
    krita-plugin-gmic

    davinci-resolve

    keepassxc
    ffmpeg
    protonup-qt

    nemo-with-extensions
  ];
}
