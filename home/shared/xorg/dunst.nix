{ pkgsSet, ... }:
{
  # TODO: Finish config
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Papirus Dark";
      package = pkgsSet.stable.papirus-icon-theme;
      size = "32";
    };
    settings = {
      global = {
        background = "#2A273F";
        class = "Dunst";
        corner_radius = 5;
        follows = "keyboard";
        foreground = "#E0DEF4";
        format = "<b>%s</b>\n<%b>";
        frame_color = "#1F1D35";
        frame_width = 2;
        indicate_hidden = "yes";
        markup = "full";
        notification_limit = 5;
        origin = "top-right";
        progress_bar = true;
        progress_bar_height = 5;
        separator_color = "frame";
        show_indicators = "yes";
        sort = "yes";
        stack_duplicates = true;
        title = "Dunst";
        word_wrap = "yes";
      };
      urgency_low = {
        frame_color = "#9CCFD8";
        timeout = 5;
      };
      urgency_normal = {
        frame_color = "#3E8FB0";
        timeout = 5;
      };
      urgency_critical = {
        frame_color = "#EB6F92";
        foreground = "#EB6F92";
        timeout = 0;
      };
    };
  };
}
