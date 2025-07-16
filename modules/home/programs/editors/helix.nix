{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

let
  cfg = config.modules.programs.editors.helix;
in
{
  key = ./helix.nix;

  options.modules.programs.editors.helix = {
    enable = lib.mkEnableOption "Helix";
    withWakaTime = lib.mkEnableOption "WakaTime";
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.mkIf cfg.withWakaTime [
      inputs.wakatime-ls.packages.${pkgs.system}.wakatime-ls
    ];
    programs.helix = {
      enable = lib.mkDefault true;
      settings = {
        theme = "rose_pine_moon";
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
      languages = {
        language-server = {
          wakatime-ls.command = "wakatime-ls";
        };
        language =
          let
            addWakaTime =
              lang:
              (
                lang
                // {
                  language-servers = (lang.language-servers or [ ]) ++ [
                    "wakatime-ls"
                  ];
                }
              );
            prettierdCfg =
              {
                name,
                ext ? name,
                ls,
              }:
              {
                inherit name;
                language-servers = ls;
                formatter = {
                  command = "prettierd";
                  args = [ ".${ext}" ];
                };
              };
          in
          builtins.map (if cfg.withWakaTime then addWakaTime else (_: _)) [
            {
              name = "cpp";
              formatter.command = "clang-format";
              language-servers = [ "clangd" ];
            }
            {
              name = "nix";
              formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
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
              language-servers = [ "qmlls" ];
            }
            (prettierdCfg {
              name = "typescript";
              ext = "ts";
              ls = [ "typescript-language-server" ];
            })
            (prettierdCfg {
              name = "javascript";
              ext = "js";
              ls = [ "typescript-language-server" ];
            })
            (prettierdCfg {
              name = "json";
              ls = [ "vscode-json-language-server" ];
            })
            (prettierdCfg {
              name = "jsonc";
              ls = [ "vscode-json-language-server" ];
            })
            (prettierdCfg {
              name = "tsx";
              ls = [ "typescript-language-server" ];
            })
            (prettierdCfg {
              name = "jsx";
              ls = [ "typescript-language-server" ];
            })
            (prettierdCfg {
              name = "css";
              ls = [ "vscode-css-language-server" ];
            })
            (prettierdCfg {
              name = "html";
              ls = [ "vscode-html-language-server" ];
            })
            (prettierdCfg {
              name = "scss";
              ls = [ "vscode-css-language-server" ];
            })
          ];
      };
    };
  };
}
