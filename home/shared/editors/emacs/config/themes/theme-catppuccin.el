;; -*- coding: utf-8; lexical-binding: t -*-

(defun config-catppuccin ()
  (load-theme 'catppuccin :no-confirm)
  (setq catppuccin-flavor 'macchiato)
  (catppuccin-reload))

(use-package catppuccin-theme
  :ensure t
  :config (config-catppuccin))

(provide 'theme-catppuccin)
