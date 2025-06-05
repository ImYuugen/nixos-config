{ lib, ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      ecosystem = {
        no_update_news = lib.mkDefault "true";
      };

      env = lib.mkOptionDefault [
        "GDK_SCALE,1"
        "GDK_BACKEND,wayland,x11,*"
        "NIXOS_OZONE_WL,1"
        "MOZ_ENABLE_WAYLAND,1"
        "SDL_VIDEODRIVER,wayland,x11,windows"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
      ];

      exec-once = lib.mkOptionDefault [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "dbus-update-activation-environment --systemd --all"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];

      general = {
        allow_tearing = lib.mkDefault "true";
      };

      input = {
        kb_layout = lib.mkDefault "us";
        kb_variant = lib.mkDefault "altgr-intl";
        kb_options = lib.mkDefault "caps:escape";
        accel_profile = lib.mkDefault "flat";
        touchpad.natural_scroll = lib.mkDefault "false";
      };

      misc = {
        initial_workspace_tracking = lib.mkDefault "1";
        force_default_wallpaper = lib.mkDefault "0";
        disable_hyprland_logo = lib.mkDefault "true";
        disable_splash_rendering = lib.mkDefault "true";
        disable_autoreload = lib.mkDefault "true";
        vfr = lib.mkDefault "false";
        vrr = lib.mkDefault "1";
        mouse_move_enables_dpms = lib.mkDefault "true";
        key_press_enables_dpms = lib.mkDefault "true";
      };

      xwayland = {
        force_zero_scaling = lib.mkDefault "true";
      };
    };
  };
}
