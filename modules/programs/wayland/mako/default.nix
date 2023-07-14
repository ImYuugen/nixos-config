{ config, pkgs, ... }:
{
  services.mako.enable = true;

  home.file."~/.config/mako/config".text = ''
    sort=-time
    max-history=100

    on-button-left=dismiss
    on-button-middle=none
    on-button-right=dismiss-all
    on-touch=dismiss

    #font
    markup=1
    default-timeout=5000
    layer=overlay

    background-color=#1e1e2e
    text-color=#cdd6f4
    border-color=#cba6f7
    progress-color=over #89b4fa

    [urgency=low]
    border-color=#313244
    default-timeout=2000

    [urgency=normal]
    border-color=#cba6f7
    default-timeout=5000

    [urgency=high]
    border-color=#f38ba8
    text-color=#f38ba8
    default-timeout=0
  '';
}
