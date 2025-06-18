;; -*- coding: utf-8; lexical-binding: t -*-

(defun feat--config-vertico ()
  (keymap-set vertico-map "TAB" #'minibuffer-complete)
  (vertico-mode))

(use-package vertico
  :custom (vertico-count 20)
  :config (feat--config-vertico))

(use-package emacs
  :ensure nil
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
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package marginalia
  :config (marginalia-mode))

(use-package company
  :config (global-company-mode))

(use-package company-box
  :if window-system
  :hook ((company-mode . company-box-mode)))

(provide 'feat-completion)
