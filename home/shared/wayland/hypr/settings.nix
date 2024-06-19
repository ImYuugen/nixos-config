{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    "$appMod" = "ALT SHIFT";

    animations = {
      enabled = "yes";
    };

    decoration = {
      rounding = "8";
    };

    dwindle = {
      no_gaps_when_only = "1";
      pseudotile = "no";
      preserve_split = "yes";
    };

    env = [
      "CLUTTER_BACKEND,wayland"
      "GDK_SCALE,1"
      "GDK_BACKEND,wayland"
      "LIBSEAT_BACKEND,logind"
      "LIBVA_DRIVER_NAME,radeonsi"
      "LIBVA_DRIVER_NAME,nvidia"
      # "GBM_BACKEND,nvidia-drm" # Firefox crashes when enabled
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "NVD_BACKEND,direct"
      "ELECTRON_OZONE_PLATFORM_HINT,auto"
      "NIXOS_OZONE_WL,1"
      "MOZ_ENABLE_WAYLAND,1"
      "SDL_VIDEODRIVER,wayland"
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_DESKTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
      "HYPRCURSOR_SIZE,20"
      "XCURSOR_SIZE,20"
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      "QT_SCALE_FACTOR,1"
      "QT_QPA_PLATFORM,wayland"
      "QT_QPA_PLATFORMTHEME,qt5ct"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "WLR_DRM_DEVICES,$HOME/.config/hypr/amdgpu:$HOME/.config/hypr/nvidia"
      "__JAVA_AWT_WM_NONREPARENTING,1"
    ];

    exec-once = [
      # !!! IMPURE
      "ln -sf /dev/dri/by-path/pci-0000:07:00.0-card $HOME/.config/hypr/amdgpu"
      "ln -sf /dev/dri/by-path/pci-0000:01:00.0-card $HOME/.config/hypr/nvidia"
      # !!!
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "dbus-update-activation-environment --systemd --all"
      "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "/usr/lib/polkit-kde-authentication-agent-1"
    ];

    general = {
      gaps_in = "0";
      gaps_out = "8";
      border_size = "1";
      "col.inactive_border" = "rgba(00000000)";
      "col.active_border" = "rgba(ffffff88)";
      layout = "dwindle";
      resize_on_border = "true";
    };

    input = {
      kb_layout = "us, fr";
      kb_options = "grp:win_space_toggle,caps:escape";
      follow_mouse = "2";
      mouse_refocus = "false";
      sensitivity = "0.2";
      accel_profile = "flat";
      touchpad = {
        natural_scroll = "true";
      };
    };

    master = { };

    misc = {
      force_default_wallpaper = "0";
      disable_hyprland_logo = "true";
      disable_splash_rendering = "true";
      disable_autoreload = "true";
      vfr = "false";
      vrr = "1";
    };

    xwayland = {
      force_zero_scaling = "true";
    };
  };
}
