{
  imports = [
    ./rules.nix
    ./settings.nix
    ./sxhkd.nix
  ];

  programs = {
    bash.initExtra = ''
      [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ] && exec startx
    '';
    fish.loginShellInit = ''
      set TTY1 (tty)
      [ "$TTY1" = "/dev/tty1" ] && exec startx
    '';
  };

  gtk = {
    enable = true;
  };

  xsession.windowManager.bspwm = {
    enable = true;
    extraConfig = ''
      bspc monitor -d 1 2 3 4 5 6 7 8 9 10
    '';
  };

  home.file.".xinitrc".text = ''
    if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
        eval $(dbus-launch --exit-with-session --sh-syntax)
    fi
    systemctl --user import-environment DISPLAY XAUTHORITY
    if command -v dbus-update-activation-environment > /dev/null 2>&1; then
        dbus-update-activation-environment DISPLAY XAUTHORITY
    fi

    fcitx5 &
    sxhkd &
    exec bspwm
  '';
}
