{ pkgsSet, lib, ... }:
{
  # home.sessionVariables.EDITOR = "hx";

  programs.helix = {
    enable = true;
    package = pkgsSet.unstable.helix;
    settings = {
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
    languages.language =
      let
        prettierdCfg =
          {
            name,
            ext ? name,
          }:
          {
            inherit name;
            auto-format = true;
            formatter = {
              command = "prettierd";
              args = [ ".${ext}" ];
            };
          };
      in
      [
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
          formatter.command = lib.getExe pkgsSet.stable.nixfmt-rfc-style;
          language-servers = [ "nil" ];
        }
        (prettierdCfg {
          name = "typescript";
          ext = "ts";
        })
        (prettierdCfg {
          name = "javascript";
          ext = "js";
        })
        (prettierdCfg { name = "json"; })
        (prettierdCfg { name = "jsonc"; })
        (prettierdCfg { name = "tsx"; })
        (prettierdCfg { name = "jsx"; })
        (prettierdCfg { name = "css"; })
        (prettierdCfg { name = "html"; })
        (prettierdCfg { name = "scss"; })
      ];
  };

  specialisation = {
    light.configuration = {
      programs.helix.settings.theme = "catppuccin_latte";
    };
    dark.configuration = {
      programs.helix.settings.theme = "catppuccin_macchiato";
    };
  };
}
