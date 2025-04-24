;;; init --- My Emacs config :3 -*- coding: utf-8; lexical-binding: t -*-

(use-package treesit-auto
  :ensure t
  :custom (treesit-auto-install 'prompt)
  :config (global-treesit-auto-mode))

(provide 'feat-treesitter)
