{ pkgsSet, ... }:
{
  # Probably not useful
  home.packages = with pkgsSet.stable; [
    wayland
    wayland-scanner
    wayland-utils
    xwayland
    kdePackages.xwaylandvideobridge
    wlroots
    wlrctl
    wlr-protocols
    wlr-randr
    wev
    egl-wayland
    glfw-wayland
    qt6.qtwayland
  ];
}
