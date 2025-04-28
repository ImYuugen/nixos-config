;; -*- coding: utf-8; lexical-binding: t -*-

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package savehist
  :config (savehist-mode))

(use-package vertico
  :ensure t
  :custom (vertico-count 20)
  :config
  (keymap-set vertico-map "TAB" #'minibuffer-complete)
  (vertico-mode))

(use-package marginalia
  :ensure t
  :config (marginalia-mode))

(defun feat--config-company ()
  (global-company-mode))

(use-package company
  :ensure t
  :config (feat--config-company))

(use-package company-box
  :ensure t
  :if window-system
  :hook ((company-mode . company-box-mode)))

(provide 'feat-completion)
