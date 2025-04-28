;; -*- coding: utf-8; lexical-binding: t -*-

(defun feat--config-zoxide ()
  (meow-leader-define-key
   '("z c" . zoxide-cd)
   '("z f" . zoxide-find-file)))

(use-package zoxide
  :ensure t
  :after meow
  :config (feat--config-zoxide))

(provide 'feat-zoxide)
