;; -*- coding: utf-8; lexical-binding: t -*-

(defun feat--config-projectile ()
  (meow-leader-define-key
   '("p s p" . projectile-switch-project)
   ;; Projectile Search
   '("p s f" . projectile-find-file)
   '("p s g" . projectile-ripgrep) ; Projectile Search Grep
   '("p s r" . projectile-replace) ; Projectile Search Replace
   '("p s R" . projectile-replace-regexp) ; Projectile Search REGEX
   '("p f r" . projectile-find-references)
   ;;
   '("p c" . projectile-commander)
   ;; Projectile Toggle
   '("p t t" . projectile-toggle-between-implementation-and-test)
   '("p t h" . projectile-find-related-file) ; Projectile Switch Header (e.g: .c <-> .h)
   ;;
   '("p !" . projectile-run-shell-command-in-root)
   '("p &" . projectile-run-async-shell-command-in-root)
   ;; Projectile Actions
   '("p a c" . projectile-compile-project)
   '("p a t" . projectile-test-project)
   '("p a i" . projectile-install-project)
   '("p a r" . projectile-run-project)
   ;; Show buffers
   '("b b" . projectile-ibuffer)
   ;; Projectile Buffers
   '("p b K" . projectile-kill-buffers)
   '("p b W" . projectile-save-project-buffers))
  (setq projectile-project-search-path '("~/Projects" "~/Bossage")))

(use-package rg
  :ensure t)

(use-package projectile
  :ensure t
  :after rg
  :config (feat--config-projectile))

(provide 'feat-projectile)
