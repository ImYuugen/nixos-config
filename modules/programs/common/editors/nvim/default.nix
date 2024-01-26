{ config, lib, inputs, pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      withNodeJs = true;
    };
  };

  home = {
    packages = with pkgs; [
      tree-sitter

      stylua
    ];
#    file.".config/nvim" = {
#      source = ./config;
#      recursive = true;
#    };
  };
}
