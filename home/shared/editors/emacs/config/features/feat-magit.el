;; -*- coding: utf-8; lexical-binding: t -*-

(defun feat--config-magit ())

;; FIXME: This one is VERY grumpy because of transient
(use-package magit
  :ensure t
  :config (feat--config-magit))

(provide 'feat-magit)
