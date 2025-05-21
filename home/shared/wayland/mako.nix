{
  services.mako = {
    enable = true;
    settings = {
      "urgency=high" = {
        border-color = "#bf616a";
        default-timeout = 0;
      };
      actions = true;
      anchor = "top-right";
      background-color = "#282239";
      border-size = 2;
      border-color = "#1F1D35";
      default-timeout = 5 * 1000;
      padding = "0,5,10";
      text-color = "#9E9AB3";
    };
  };

  wayland.windowManager.hyprland.settings.exec-once = [ "mako" ];
}
