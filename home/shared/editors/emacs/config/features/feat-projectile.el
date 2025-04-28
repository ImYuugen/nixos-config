;; -*- coding: utf-8; lexical-binding: t -*-

(defun feat--config-projectile ())

(use-package projectile
  :ensure t
  :config (feat--config-projectile))

(provide 'feat-projectile)
