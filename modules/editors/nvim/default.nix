{ config, lib, inputs, pkgs, ... }:

{
  nixpkgs.config = {
    programs.npm.npmrc = ''
      prefix = ''${HOME}/.npm-global
    '';
  };

  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      withNodeJs = true;
      extraPackages = [
      ];

      plugins = with pkgs.vimPlugins; [];
    };
  };

  home = {
    packages = with pkgs; [
      # LSP
      nodePackages_latest.bash-language-server
      rnix-lsp
      nil
      nixd
      lua-language-server
      pyright
      rust-analyzer
      clang-tools

      tree-sitter

      # Formatters
      stylua
      black #Python
      nixpkgs-fmt
      rustfmt
      beautysh

      lldb
    ];
  };

  # TODO: Nvim config
  home.file.".config/nvim/init.vim".source = ./init.vim;
}
