{ config, lib, inputs, pkgs, ... }:

let
  ts_grammars = (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.bash
    p.c
    p.cpp
    p.css
    p.fish
    p.go
    p.haskell
    p.html
    p.json
    p.llvm
    p.lua
    p.make
    p.markdown
    p.nix
    p.ninja
    p.python
    p.rasi
    p.rust
    p.toml
    p.typescript
    p.wgsl
  ]));
in
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    withNodeJs = true;
    plugins = [ ts_grammars ];
  };

  home = {
    file = {
      ".config/nvim" = {
        source = ./nvim;
        recursive = true;
      };

      ".local/share/nvim/nix/nvim-treesitter" = {
        source = ts_grammars;
        recursive = true;
      };
    };
  };
}
