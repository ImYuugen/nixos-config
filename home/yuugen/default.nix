{ inputs
, pkgsSet
, ...
}: {
  home-manager.extraSpecialArgs = {
    inherit inputs pkgsSet;
  };
  home-manager.users.yuugen = {
    # Ooh that's a lot of words
    imports = [
      ./git.nix
      ../shared/communications/discord.nix
      ../shared/communications/slack.nix
      ../shared/communications/thunderbird.nix
      # ../shared/files.nix
      ../shared/firefox
      ../shared/editors/helix.nix
      ../shared/environment.nix
      ../shared/gaming.nix
      ../shared/media/mpv.nix
      ../shared/media/spotify.nix
      # ../shared/media/vlc.nix
      ../shared/media/utils.nix
      # ../shared/media/yt-dlp.nix
      ../shared/production/obs.nix
      ../shared/production/krita.nix
      # ../shared/productivity/libreoffice.nix
      ../shared/shells/fish.nix
      # ../shared/shells/bash.nix
      ../shared/sound/easyeffects.nix
      ../shared/utils
      # ../shared/vpn.nix
      # ../shared/wayland
      # ../shared/wayland/ags
      # ../shared/wayland/hypr
      # ../shared/wayland/kanshi.nix
      # ../shared/wayland/launcher
      # ../shared/wayland/mako.nix
      ../shared/xorg
      ../shared/xorg/autorandr.nix
      ../shared/xorg/bspwm
      ../shared/xorg/dunst.nix
      ../shared/xorg/launcher
      ../shared/xorg/lockscreen.nix
      ../shared/wezterm
    ];

    home = rec {
      username = "yuugen";
      homeDirectory = "/home/${username}";
      stateVersion = "23.11";
    };
  };
}
