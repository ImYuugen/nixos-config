{ config, pkgs, ... }:
{
  services.mako.enable = true;

  home.file."~/.config/mako/config".text = ''
    background-color=#282828bb
    text-color=#ebdbb8

    margin=5
    padding=8

    border-size=1
    border-color=#d79921cc
    border-radius=6

    progress-color=source #383838

    format=<sup>%a</sup>\n<b>%s</b>\n%b

    default-timeout=5000

    group-by=app-name

    [urgency=critical]
    border-size=2
    border-color=#cc2222cc

    [urgency=low]
    text-color=#bbab88

    [mode=away]
    default-timeout=0
    ignore-timeout=1
  '';
}
