;;; init --- My Emacs config :3 -*- coding: utf-8; lexical-binding: t -*-

(use-package doom-modeline
  :ensure t
  :custom
  (doom-modeline-buffer-encoding nil)
  (doom-modeline-enable-word-count t)
  (doom-modeline-hud t)
  :config
  (doom-modeline-mode))

(provide 'feat-doom-modeline)
