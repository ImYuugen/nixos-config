{ config, pkgs, ... }:

{
  programs.yt-dlp.enable = true;

  home.file.".config/yt-dlp/config".text = ''
    --ignore-errors
    -o ~/Videos/%(title)s.%(ext)s
    -f bestvideo[ext=mp4][width=1920][height=1080]+bestaudio[ext=m4a]
  '';
}
