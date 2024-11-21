{ pkgsSet, ... }:
{
  home.packages = with pkgsSet.stable; [ clipse ];

  wayland.windowManager.hyprland.settings.exec-once = [ "clipse -listen" ];
}
