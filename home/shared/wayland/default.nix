{ pkgsSet, ... }: {
  nix = {
    settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
  };

  # Probably not useful
  home.packages = with pkgsSet.stable; [
    wayland
    wayland-scanner
    wayland-utils
    xwayland
    wlroots
    wlrctl
    wlr-protocols
    wlr-randr
    xdg-desktop-portal-wlr
    wev
    egl-wayland
    glfw-wayland
    qt6.qtwayland
  ];
}
