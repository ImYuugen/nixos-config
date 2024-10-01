{ pkgsSet, ... }: {
  # home.sessionVariables.EDITOR = "hx";

  programs.helix = {
    enable = true;
    package = pkgsSet.unstable.helix;
    settings = {
      theme = "rose_pine_moon";
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
          unit = "\t";
        };
      }
      {
        name = "nix";
        auto-format = true;
        formatter = {
          command = "nix fmt";
        };
        language-servers = [ "nil" ];
      }
    ];
  };
}
