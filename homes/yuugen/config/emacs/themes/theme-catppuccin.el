;; -*- coding: utf-8; lexical-binding: t -*-

(defun theme--config-catppuccin ()
  ;; TODO: Darkman
  (setq catppuccin-flavor 'mocha)
  (load-theme 'catppuccin :no-confirm)
  (add-hook 'server-after-make-frame-hook #'catppuccin-reload))

(use-package catppuccin-theme
  :config (theme--config-catppuccin))

(provide 'theme-catppuccin)
