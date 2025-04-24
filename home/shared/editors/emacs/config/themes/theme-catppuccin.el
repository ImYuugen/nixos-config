;; -*- coding: utf-8; lexical-binding: t -*-

(defun config-catppuccin ()
  (load-theme 'catppuccin :no-confirm)
  (darkman-set-light-callback (lambda () (catppuccin-load-flavor 'latte)))
  (darkman-set-dark-callback (lambda () (catppuccin-load-flavor 'macchiato)))
  (darkman-exec-callback)
  (catppuccin-reload))

(use-package catppuccin-theme
  :ensure t
  :config (config-catppuccin))

(provide 'theme-catppuccin)
