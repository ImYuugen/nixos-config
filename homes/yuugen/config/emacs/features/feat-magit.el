;;; -*- coding: utf-8; lexical-binding: t -*-

(defun feat--config-magit ()
  (meow-leader-define-key
   ;; Git bindings
   '("g g" . magit)
   ))

(use-package magit
  :after meow
  :custom
  (magit-commit-arguments '("-S"))
  (magit-revert-buffers 'silent)
  :config
  (feat--config-magit))

;; Force transient to >9.0.0
(use-package transient
  :ensure (:host github :repo "magit/transient")
  :defer t
  :custom
  (transient-history-file (concat cache-dir "transient/history.el"))
  (transient-levels-file (concat cache-dir "transient/level.el"))
  (transient-values-file (concat cache-dir "transient/values.el")))

(defun feat--config-magit-delta ()
  (let ((delta-bin (executable-find "delta")))
	(when delta-bin
	  (magit-delta-mode 1))))

(use-package magit-delta
  :config (feat--config-magit-delta))

(provide 'feat-magit)
