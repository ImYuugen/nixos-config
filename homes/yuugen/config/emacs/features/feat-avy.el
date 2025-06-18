;; -*- coding: utf-8; lexical-binding: t -*-

(defun config-avy ()
  (meow-leader-define-key
   '("a g c" . avy-goto-char-2)
   '("a g w" . avy-goto-word-1)
   '("a k l" . avy-kill-whole-line)
   '("a k L" . avy-kill-ring-save-whole-line)
   '("a k r" . avy-kill-region)
   '("a k R" . avy-kill-ring-save-region)
   '("a m l" . avy-move-line)
   '("a m r" . avy-move-region)
   '("a y l" . avy-copy-line)
   '("a y r" . avy-copy-region)))

(use-package avy
 :after meow
  :config (config-avy))

(provide 'feat-avy)
