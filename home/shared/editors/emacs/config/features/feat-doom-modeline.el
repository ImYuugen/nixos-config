;;; init --- My Emacs config :3 -*- coding: utf-8; lexical-binding: t -*-

(defun config-doom-modeline ()
  (doom-modeline-mode 1))

(use-package doom-modeline
  :ensure t
  :config (config-doom-modeline))

(provide 'feat-doom-modeline)
