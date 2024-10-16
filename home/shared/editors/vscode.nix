{ pkgsSet, ... }:
let
  pkgs = pkgsSet.stable;
in
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      asvetliakov.vscode-neovim
      mvllow.rose-pine
    ];
  };
}
