;; -*- coding: utf-8; lexical-binding: t -*-

(defun theme--config-catppuccin ()
  ;; TODO: Darkman
  (setq catppuccin-flavor 'latte)
  (load-theme 'catppuccin :no-confirm)
  (add-hook 'server-after-make-frame-hook #'catppuccin-reload))

(use-package catppuccin-theme
  :ensure t
  :config (theme--config-catppuccin))

(provide 'theme-catppuccin)
