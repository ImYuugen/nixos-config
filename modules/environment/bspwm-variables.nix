{ config, pkgs, ... }:

{
  home = {
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "alacritty";

      GDK_SCALE = "1";
      GDK_DPI_SCALE = "1";

      GLFW_IM_MODULE = "ibus";
      QT_QPA_PLATFORMTHEME = "gtk3";
      XDG_CACHE_HOME = "\${HOME}/.cache";
      XDG_CONFIG_HOME = "\${HOME}/.config";
      XDG_BIN_HOME = "\${HOME}/.local/bin";
      XDG_DATA_HOME = "\${HOME}/.local/share";
    };
    sessionPath = [
      "$HOME/.local/bin"
    ];
  };
}
