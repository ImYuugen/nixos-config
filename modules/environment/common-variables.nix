{ config, pkgs, ... }:

{
  home = {
    sessionVariables = {
      BROWSER = "firefox";
      TERMINAL = "kitty";
      EDITOR = "hx";

      XDG_CONFIG_HOME = "\${HOME}/.config";
      XDG_CACHE_HOME = "\${HOME}/.cache";
      XDG_BIN_HOME = "\${HOME}/.local/bin";
      XDG_DATA_HOME = "\${HOME}/.local/share";
      XDG_PICTURES_DIR = "\${HOME}/Images";
      XDG_SCREENSHOTS_DIR = "\${HOME}/Images/Screenshots";

      STEAM_EXTRA_COMPAT_TOOLS_PATH = "\${HOME}/.steam/root/compatibilitytools.d";
    };
    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/.cargo/bin"
    ];
  };
}
