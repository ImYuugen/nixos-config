;; -*- coding: utf-8; lexical-binding: t -*-

(defun feat--init-consult ()
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)
  (advice-add #'register-preview :override #'consult-register-window)
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref))

(defun feat--config-consult ()
  (consult-customize consult-theme :preview-key '(:debounce 0.2 any)
                     consult-ripgrep consult-git-grep consult-grep
                     consult-bookmark consult-recent-file consult-xref
                     :preview-key '(:debounce 0.4 any))
  (setq consult-narrow-key "<"))

(use-package consult
  :ensure t
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init (feat--init-consult)
  :config (feat--config-consult))

(provide 'feat-consult)
