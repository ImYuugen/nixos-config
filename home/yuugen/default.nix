{
  home-manager.users.yuugen = {
    # Ooh that's a lot of words
    imports = [
      ../shared/communications/discord.nix
      ../shared/communications/thunderbird.nix
      ../shared/files.nix
      ../shared/firefox
      ../shared/editors/helix.nix
      ../shared/environment.nix
      ../shared/gaming.nix
      ../shared/git.nix
      ../shared/media/mpv.nix
      ../shared/media/spotify.nix
      ../shared/media/vlc.nix
      ../shared/media/yt-dlp.nix
      ../shared/obs.nix
      ../shared/productivity/libreoffice.nix
      ../shared/shells/fish.nix
      ../shared/shells/bash.nix
      ../shared/sound/easyeffects.nix
      ../shared/utils.nix
      ../shared/vpn.nix
      ../shared/wayland/ags
      ../shared/wayland/hypr
      ../shared/wayland/kanshi.nix
      ../shared/wayland/launcher.nix
      ../shared/wayland/mako.nix
      ../shared/wezterm.nix
    ];

    home = rec {
      username = "yuugen";
      homeDirectory = "/home/${username}";
      stateVersion = "23.11";
    };
  };
}
