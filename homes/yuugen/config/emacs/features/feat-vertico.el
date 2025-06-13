;; -*- coding: utf-8; lexical-binding: t -*-

(defun feat--vertico-config ()
  (keymap-set vertico-map "TAB" #'minibuffer-complete)
  (vertico-mode))

(use-package vertico
  :ensure t
  :config (feat--vertico-config))

(use-package emacs
  :custom
  (context-menu-mode t)
  (enable-recursive-minibuffers t)
  (read-extended-command-predicate #'command-completion-default-include-p)
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))

(setq read-file-name-completion-ignore-case t
	  read-buffer-completion-ignore-case t
	  completion-ignore-case t)

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion))))
  :ensure t)

(provide 'feat-vertico)
