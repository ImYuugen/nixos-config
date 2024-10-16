{ pkgsSet, ... }:
{
  # Probably not useful
  home.packages = with pkgsSet.stable; [
    wayland
    wayland-scanner
    wayland-utils
    xwayland
    xwaylandvideobridge
    wlroots
    wlrctl
    wlr-protocols
    wlr-randr
    wev
    egl-wayland
    glfw-wayland
    qt6.qtwayland
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgsSet.stable; [ xdg-desktop-portal-wlr ];
  };
}
