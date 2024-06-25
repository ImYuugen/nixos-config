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
  };
}
