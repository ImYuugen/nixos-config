{ inputs
, lib
, pkgsSet
, ...
}:
let
  pkgs = pkgsSet.unstable;
  tsGrammars = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
    p.arduino
    p.asm
    p.bash
    p.c
    p.cmake
    p.cpp
    p.css
    p.cuda
    p.diff
    p.dockerfile
    p.doxygen
    p.fish
    p.git_rebase
    p.git_config
    p.gitattributes
    p.gitcommit
    p.gitignore
    p.glsl
    p.go
    p.haskell
    p.html
    p.http
    p.hyprlang
    p.java
    p.javascript
    p.json
    p.latex
    p.llvm
    p.lua
    p.make
    p.markdown
    p.meson
    p.nix
    p.objdump
    p.ocaml
    p.python
    p.rasi
    p.ron
    p.rst
    p.rust
    p.scss
    p.tiger
    p.toml
    p.typescript
    p.wgsl
    p.yaml
    p.zig
  ]);
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;

    plugins = with pkgs.vimPlugins; [
      lz-n
      vim-startuptime

      # Theming
      rose-pine

      # Functional
      aerial-nvim
      bufferline-nvim
      dashboard-nvim
      dressing-nvim
      gitsigns-nvim
      lspkind-nvim
      lualine-nvim
      mini-nvim
      multicursors-nvim
      neo-tree-nvim
      noice-nvim
      nui-nvim
      nvim-lsp-notify
      nvim-navic
      nvim-notify
      nvim-web-devicons
      toggleterm-nvim
      trouble-nvim
      vim-repeat
      which-key-nvim

      # Leap
      leap-nvim
      flit-nvim

      # Project management
      project-nvim

      # Appearance
      indent-blankline-nvim
      vim-illuminate

      # Comments
      nvim-ts-context-commentstring
      todo-comments-nvim

      # [LSP]
      actions-preview-nvim
      lazydev-nvim
      none-ls-nvim
      nvim-lightbulb
      nvim-lspconfig
      SchemaStore-nvim
      # [[Rust]]
      rustaceanvim
      crates-nvim

      # Dap me up
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text

      # Testing
      neotest
      neotest-rust

      # Completion
      cmp-buffer
      cmp-nvim-lsp
      cmp-async-path
      cmp-treesitter
      nvim-cmp

      # Search
      flash-nvim
      nvim-spectre
      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim

      # Treesitter
      nvim-treesitter-context
      nvim-treesitter-textobjects
      nvim-treesitter-textsubjects
      tsGrammars
    ];
    extraPackages = with pkgs; [
      gcc # For treesitter
    ];
  };

  # xdg.configFile."nvim/" = {
  #   source = ./config;
  #   recursive = true;
  # };
}
