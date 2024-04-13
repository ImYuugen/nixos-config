{
  main-bar = {
    layer = "top";
    position = "top";

    modules-left = [
      "hyprland/workspaces"
    ];
    modules-center = [ ];
    modules-right = [
      "wireplumber"
      "battery"
      "clock"
      "tray"
    ];

    "hyprland/workspaces" = {
      active-only = true;
      all-outputs = true;
      format-icons = {
        "1" = "1";
        "2" = "2";
        "3" = "3";
        "4" = "4";
        "5" = "5";
        "6" = "6";
        "7" = "7";
        "8" = "8";
        "9" = "9";
        "10" = "10";
      };
    };

    "wireplumber" = {
      format = "{volume}%";
      format-muted = "🤫";
      format-icons = [ "" "󰖀" "󰕾" ];
      max-volume = 150;
      scroll-step = 5;
    };

    "battery" = {
      format = "{capacity}% {icon}";
      format-icons = [ " " " " " " " " " " ];
      states = {
        warning = 30;
        critical = 10;
      };
    };

    "clock" = {
      timezones = [ "Europe/Paris" "Asia/Tokyo" ];
      format = "{:%H:%M}";
      tooltip = true;
      tooltip-format = "{:%Y-%m-%d}";
      actions = {
        on-click-forward = "tz_up";
        on-click-backward = "tz_down";
        on-scroll-up = "shift_up";
        on-scroll-down = "shift_down";
      };
    };

    "tray" = {
      icon-size = 21;
    };
  };
}
