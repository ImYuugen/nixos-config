;; -*- coding: utf-8; lexical-binding: t -*-

(use-package nix-ts-mode
  :ensure t
  :mode "\\.nix\\'")

(use-package nixfmt
  :ensure t
  :hook (nix-ts-mode . nixfmt-on-save-mode))

(provide 'mode-nix)
