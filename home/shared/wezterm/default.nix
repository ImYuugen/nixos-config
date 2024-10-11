{
  inputs,
  pkgsSet,
  ...
}: {
  home.sessionVariables.TERMINAL = "wezterm";

  programs.wezterm = {
    enable = true;
    package = inputs.wezterm.packages.${pkgsSet.stable.system}.default;
  };

  xdg.configFile."wezterm" = {
    source = ./wezterm;
    recursive = true;
  };
}
