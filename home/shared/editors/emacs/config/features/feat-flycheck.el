;; -*- coding: utf-8; lexical-binding: t -*-

(defun config-flycheck ()
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  (global-flycheck-mode))

(use-package flycheck
  :ensure t
  :config (config-flycheck))

(provide 'feat-flycheck)
