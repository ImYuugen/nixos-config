;;; init --- My Emacs config :3 -*- coding: utf-8; lexical-binding: t -*-

(defun config-indent-bars ()
  (setq indent-bars-no-descend-lists t)
  (setq indent-bars-treesit-support t)
  (setq indent-bars-treesit-ignore-blank-lines-type '("module"))
  (indent-bars-mode))

(use-package indent-bars
  :config (config-indent-bars))

(provide 'feat-indent-bars)
