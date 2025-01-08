{ inputs, pkgsSet, ... }:
let
  pkgs = pkgsSet.unstable;
  volt = pkgs.vimUtils.buildVimPlugin {
    name = "volt";
    src = pkgs.fetchFromGitHub {
      owner = "NvChad";
      repo = "volt";
      rev = "4472da2e77ad240e7fc56af6357b2a8fdf6aa0ae";
      hash = "sha256-i5gbXzJK7LpfUZbP/RG0wD0SWUj1EwUJq8Z+IEN3Ihg=";
    };
  };
  tsGrammars = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
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
    p.regex
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

      # Theming
      rose-pine

      # Functional
      alpha-nvim
      bufferline-nvim
      cmp-async-path
      cmp-buffer
      cmp-nvim-lsp
      cmp-treesitter
      conform-nvim
      # cord-nvim # Funny but oooh the leaks ooh the leaks
      crates-nvim
      fidget-nvim
      flash-nvim
      flit-nvim
      gitsigns-nvim
      guess-indent-nvim
      indent-blankline-nvim
      lazydev-nvim
      leap-nvim
      lspkind-nvim
      lualine-nvim
      luasnip
      mini-indentscope
      mini-nvim
      mini-pairs
      multicursors-nvim
      neotest
      neo-tree-nvim
      noice-nvim
      nui-nvim
      nvim-cmp
      nvim-colorizer-lua
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text
      nvim-lightbulb
      nvim-lspconfig
      nvim-lsp-notify
      nvim-navbuddy
      nvim-navic
      nvim-notify
      nvim-ufo
      nvim-spectre
      nvim-surround
      nvim-treesitter-context
      nvim-treesitter-textobjects
      nvim-treesitter-textsubjects
      tsGrammars
      nvim-ts-context-commentstring
      nvim-web-devicons
      plenary-nvim
      project-nvim
      rustaceanvim
      todo-comments-nvim
      toggleterm-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      trouble-nvim
      vim-illuminate
      vim-repeat
      volt
      which-key-nvim
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
