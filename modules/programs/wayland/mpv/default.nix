{ lib, pkgs, user, ... }:
{
  programs.mpv.enable = true;

  home.file."~/.config/mpv/mpv.conf".text = ''
    gpu-api=opengl
    gpu-context=wayland
    hwdec=auto-safe
    vo=gpu
    profile=gpu-hq
    script-opts=ytdl_hook-ytdl_path=yt-dlp
  '';

  home.file."~/.config/mpv/scripts/file-browser.lua".source = ./scripts/file-browser.lua;
}
