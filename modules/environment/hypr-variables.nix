{ config, pkgs, ... }:

{
  home = {
    sessionVariables = {
      CLUTTER_BACKEND = "wayland";

      GDK_SCALE = "1";
      GDK_BACKEND = "wayland";

      LIBSEAT_BACKEND = "logind";

      LIBVA_DRIVER_NAME = "radeonsi";
#      LIBVA_DRIVER_NAME = "nvidia";
#      GBM_BACKEND = "nvidia-drm";
#      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NVD_BACKEND = "direct";

      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      NIXOS_OZONE_WL = 1;

      MOZ_ENABLE_WAYLAND = "1";

      SDL_VIDEODRIVER = "wayland";

      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";

      HYPRCURSOR_THEME = "rose-pine-hyprcursor";
      HYPRCURSOR_SIZE = "20";

      XCURSOR_SIZE = "20";

      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      WLR_DEVICES = "/dev/dri/card1:/dev/dri/card0";
      WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
      WLR_RENDERER = "vulkan";

      __JAVA_AWT_WM_NONREPARENTING = "1";
    };
  };
}
