{
  home = {
    sessionVariables = {
      XDG_CONFIG_HOME = "\${HOME}/.config";
      XDG_CACHE_HOME = "\${HOME}/.cache";
      XDG_BIN_HOME = "\${HOME}/.local/bin";
      XDG_DATA_HOME = "\${HOME}/.local/share";
      XDG_PICTURES_DIR = "\${HOME}/Images";
      XDG_SCREENSHOTS_DIR = "\${HOME}/Images/Screenshots";
    };
    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/.cargo/bin"
    ];
  };
}
