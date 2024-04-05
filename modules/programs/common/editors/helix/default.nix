{ config, pkgs, unstable, ... }:

{
  programs.helix = {
    enable = true;
    package = unstable.helix;
    settings = {
      theme = "gruvbox";
      editor = {
        line-number = "relative";
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        cursor-shape = {
          insert = "bar";
          select = "underline";
        };
      };
    };
    languages.language = [
      {
        name = "cpp";
        auto-format = true;
        formatter = {
          command = "clang-format";
        };
        language-servers = [ "clangd" ];
        indent = {
          tab-width = 4;
          unit = "    ";
        };
      }
    ];
  };
}
