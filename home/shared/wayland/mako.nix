{
  # TODO: Finish config
  services.mako = {
    enable = true;
    defaultTimeout = 5 * 1000;
    extraConfig = ''
      [urgency=high]
      border-color=#bf616a
      default-timeout=0
    '';
    anchor = "top-right";
    backgroundColor = "#282239";
    borderSize = 2;
    borderColor = "#1F1D35";
    padding = "0,5,10";
    textColor = "#9E9AB3";
  };

  wayland.windowManager.hyprland.settings.exec-once = [
    "mako"
  ];
}
