{
  config,
  lib,
  pkgsSet,
  ...
}:

let
  cfg = config.modules.programs.editors.helix;
in
{
  options.modules.programs.editors.helix = {
    enable = lib.mkEnableOption "Helix";
  };

  config = lib.mkIf cfg.enable {
    programs.helix = {
      enable = lib.mkDefault true;
      settings = {
        editor = {
          line-number = lib.mkDefault "relative";
          lsp = {
            display-messages = lib.mkDefault true;
            display-inlay-hints = lib.mkDefault true;
            display-progress-messages = lib.mkDefault true;
          };
          cursor-shape = {
            insert = lib.mkDefault "bar";
            select = lib.mkDefault "underline";
          };
          file-picker = {
            hidden = lib.mkDefault false;
          };
          indent-guides = {
            render = lib.mkDefault true;
            character = lib.mkDefault "╎";
          };
          soft-wrap = {
            enable = lib.mkDefault true;
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
              formatter = {
                command = "prettierd";
                args = [ ".${ext}" ];
              };
            };
        in
        [
          {
            name = "cpp";
            formatter.command = "clang-format";
          }
          {
            name = "nix";
            formatter.command = lib.getExe pkgsSet.stable.nixfmt-rfc-style;
            language-servers = [
              "nixd"
              "nil"
            ];
          }
          {
            name = "qml";
            formatter = {
              command = "qmlformat";
              args = [
                "--normalize"
              ];
            };
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
  };
}
