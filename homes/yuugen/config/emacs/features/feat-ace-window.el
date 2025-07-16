;; -*- coding: utf-8; lexical-binding: t -*-

(defun config-ace-window ()
  (global-set-key (kbd "M-o") 'ace-window)
  (setq aw-background nil))

(use-package ace-window
  :config (config-ace-window))

(provide 'feat-ace-window)
