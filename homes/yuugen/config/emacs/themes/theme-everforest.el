;; -*- coding: utf-8; lexical-binding: t -*-

(defun theme--config-everforest ()
  (load-theme 'everforest-hard-dark :no-confirm))

(use-package everforest
  :ensure (
    :host github
    :repo "Theory-of-Everything/everforest-emacs"
  )
  :config (theme--config-everforest))

(provide 'theme-everforest)
