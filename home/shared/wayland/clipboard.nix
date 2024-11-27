{ pkgsSet, ... }:
{
  home.packages = with pkgsSet.stable; [
    clipse
    wl-clipboard
  ];

  wayland.windowManager.hyprland.settings.exec-once = [ "clipse -listen" ];
}
