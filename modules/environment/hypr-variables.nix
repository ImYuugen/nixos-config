{ config, pkgs, ... }:

{
  home = {
    sessionVariables = {
      CLUTTER_BACKEND = "wayland";

      GDK_SCALE = "1";
      GDK_BACKEND = "wayland";

      LIBSEAT_BACKEND = "logind";

      LIBVA_DRIVER_NAME = "amdgpu";

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
      WLR_NO_HARDWARE_CURSORS = "1";
      WLR_RENDER_DRM_DEVICE = "/dev/dri/card1";
      WLR_RENDERER = "vulkan";

      __JAVA_AWT_WM_NONREPARENTING = "1";
    };
  };
}
