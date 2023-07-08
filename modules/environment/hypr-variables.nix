{ config, pkgs, ... }:
{
  home = { 
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "alacritty";

      QT_QPA_PLATFORMTHEME = "gtk3";
      QT_QPA_PLATFORM = "wayland";
      QT_SCALE_FACTOR = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      MOZ_ENABLE_WAYLAND = "1";
      SDL_VIDEODRIVER = "wayland";
      __JAVA_AWT_WM_NONREPARENTING = "1";
      WLR_DRM_DEVICES = "/dev/dri/card1";
      WLR_NO_HARDWARE_CURSORS = "1"; # Enable if cursor becomes transparent
      WLR_DRM_NO_ATOMIC = "1";
      WLR_RENDERER_ALLOW_SOFTWARE = "1";
      WLR_RENDER_DRM_DEVICE = "/dev/dri/card1";
      WLR_RENDERER = "vulkan";
      CLUTTER_BACKEND = "wayland";

      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";

      LIBSEAT_BACKEND = "logind";

      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_CACHE_HOME = "\${HOME}/.cache";
      XDG_CONFIG_HOME = "\${HOME}/.config";
      XDG_BIN_HOME = "\${HOME}/.local/bin";
      XDG_DATA_HOME = "\${HOME}/.local/share";
    };
    sessionPath = [
      "$HOME/.local/bin"
    ];
  };
}
