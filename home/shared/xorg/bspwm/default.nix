{
  imports = [
    ./rules.nix
    ./settings.nix
  ];

  programs = {
    bash.initExtra = ''
      [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ] && exec Hyprland
    '';
    fish.loginShellInit = ''
      set TTY1 (tty)
      [ "$TTY1" = "/dev/tty1" ] && exec Hyprland
    '';
  };

  gtk = {
    enable = true;
  };

  xsession.windowManager.bspwm = {
    enable = true;
  };
}
