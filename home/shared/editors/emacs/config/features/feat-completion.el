;; -*- coding: utf-8; lexical-binding: t -*-

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package savehist
  :config (savehist-mode))

(use-package vertico
  :custom (vertico-count 20)
  :config (vertico-mode))

(use-package marginalia
  :config (marginalia-mode))

(provide 'feat-completion)
