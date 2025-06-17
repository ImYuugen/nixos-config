;; -*- coding: utf-8; lexical-binding: t -*-

(use-package flycheck
  :ensure t
  :config (global-flycheck-mode))

(use-package lsp-mode
  :ensure t
  :hook
  (lsp-mode . lsp-enable-which-key-integration)
  :custom
  (lsp-completion-provider :none)
  (lsp-diagnostics-provider :flycheck)
  (lsp-session-file (locate-user-emacs-file ".lsp-session"))
  (lsp-log-io nil)
  (lsp-keep-workspace-alive nil)
  (lsp-idle-delay 0.5)
  (lsp-enable-xref t)
  (lsp-auto-configure t)
  (lsp-enable-dap-auto-configure t)
  (lsp-enable-suggest-server-download nil) ; Manage with nix shell/flake
  (lsp-enable-test-document-color nil) ; Treesitter's job
  (lsp-completion-enable t)
  (lsp-completion-enable-additional-text-edit t)
  (lsp-enable-snippet t)
  (lsp-completion-show-kind t))

(use-package lsp-completion
  :no-require
  :hook ((lsp-mode . lsp-completion-mode)))

(use-package lsp-ui
  :ensure t
  :commands
  (lsp-ui-doc-show
   lsp-ui-doc-glance)
  :bind
  (:map lsp-mode-map
        ("C-c C-d" . 'lsp-ui-doc-glance))
  :after (lsp-mode)
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-show-with-cursor nil
        lsp-ui-doc-include-signature t
        lsp-ui-doc-position 'at-point))

(provide 'feat-lsp)
