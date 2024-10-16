{ pkgsSet, ... }:
{
  programs.mpv = {
    enable = true;
    config = {
      cache = true;
      force-seekable = true;
    };
    scripts = with pkgsSet.stable.mpvScripts; [
      thumbnail
      uosc
      videoclip
      webtorrent-mpv-hook
    ];
  };
}
