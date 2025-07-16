;; -*- coding: utf-8; lexical-binding: t -*-

(defun feat--config-centaur-tabs ()
  (setq centaur-tabs-style "slant")
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-icon-type 'nerd-icons)
  (setq centaur-tabs-gray-out-icons 'buffer)
  (setq centaur-tabs-set-modified-marker t)
  (centaur-tabs-mode)

  (meow-leader-define-key
   '("b s g" . centaur-tabs-switch-group)
   '("b s h" . centaur-tabs-backward)
   '("b s l" . centaur-tabs-forward)))

(defun feat--centaur-tabs-hide-tab (x)
  (let ((name (format "%s" x)))
    (or
     (window-dedicated-p (selected-window))

     ;; Buffer name not match below blacklist.
     (string-prefix-p "*epc" name)
     (string-prefix-p "*helm" name)
     (string-prefix-p "*Helm" name)
     (string-prefix-p "*Compile-Log*" name)
     (string-prefix-p "*lsp" name)
     (string-prefix-p "*company" name)
     (string-prefix-p "*Flycheck" name)
     (string-prefix-p "*tramp" name)
     (string-prefix-p " *Mini" name)
     (string-prefix-p "*help" name)
     (string-prefix-p "*straight" name)
     (string-prefix-p " *temp" name)
     (string-prefix-p "*Help" name)
     (string-prefix-p "*mybuf" name)

     ;; Is not magit buffer.
     (and (string-prefix-p "magit" name)
          (not (file-name-extension name)))
     )))

(use-package centaur-tabs
  :after meow
  :config (feat--config-centaur-tabs))

(provide 'feat-centaur-tabs)
