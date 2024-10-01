{ inputs
, pkgsSet
, ...
}:
let
  pkgs = pkgsSet.unstable;
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
      cmp-path
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
      nvim-treesitter.withAllGrammars
    ];
    extraPackages = with pkgs; [
      gcc # For treesitter
      vscode-langservers-extracted
    ];
  };

  # xdg.configFile."nvim/" = {
  #   source = ./config;
  #   recursive = true;
  # };
}
