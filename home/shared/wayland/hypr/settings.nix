{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    "$appMod" = "ALT SHIFT";

    animations = {
      enabled = "yes";
    };

    animation = [
      "windows, 1, 7, default, slide"
      "windowsOut, 0"
      "fadeIn, 0"
      "fadeOut, 0"
      "workspaces, 1, 5, default"
    ];

    decoration = {
      rounding = "8";
    };

    dwindle = {
      pseudotile = "no";
      preserve_split = "yes";
    };

    env = [
      "GDK_SCALE,1"
      "GDK_BACKEND,wayland,x11,*"
      "LIBSEAT_BACKEND,logind"
      "LIBVA_DRIVER_NAME,radeonsi"
      "LIBVA_DRIVER_NAME,nvidia"
      # "GBM_BACKEND,nvidia-drm" # Firefox crashes when enabled
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "NVD_BACKEND,direct"
      "ELECTRON_OZONE_PLATFORM_HINT,auto"
      "NIXOS_OZONE_WL,1"
      "MOZ_ENABLE_WAYLAND,1"
      "SDL_VIDEODRIVER,wayland,x11,windows" # Easy anti cheat
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_DESKTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
      "HYPRCURSOR_SIZE,20"
      "XCURSOR_SIZE,20"
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      "QT_SCALE_FACTOR,1"
      "QT_QPA_PLATFORM,wayland;xcb"
      "QT_QPA_PLATFORMTHEME,qt5ct"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "WLR_DRM_DEVICES,$HOME/.config/hypr/amdgpu:$HOME/.config/hypr/nvidia"
      "AQ_DRM_DEVICES,$HOME/.config/hypr/amdgpu:$HOME/.config/hypr/nvidia"
      "__JAVA_AWT_WM_NONREPARENTING,1"
    ];

    exec-once = [
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "dbus-update-activation-environment --systemd --all"
      "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "/usr/lib/polkit-kde-authentication-agent-1"
      "systemctl --user start hyprpolkitagent"
      "hyprsunset"
      "fcitx5 &"
    ];

    general = {
      allow_tearing = "true";
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
      kb_variant = "altgr-intl,";
      kb_options = "grp:win_space_toggle,caps:escape";
      follow_mouse = "2";
      mouse_refocus = "false";
      sensitivity = "0.2";
      accel_profile = "flat";
      touchpad = {
        natural_scroll = "false";
      };
    };

    master = { };

    misc = {
      # Windows always appear on ws they were invoked on
      initial_workspace_tracking = "1";
      force_default_wallpaper = "0";
      disable_hyprland_logo = "true";
      disable_splash_rendering = "true";
      disable_autoreload = "true";
      vfr = "false";
      vrr = "1";
    };

    # Set default scale to 1
    monitor = [ ",preferred,auto,1" ];

    xwayland = {
      force_zero_scaling = "true";
    };
  };
}
