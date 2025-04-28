;; -*- coding: utf-8; lexical-binding: t -*-

(use-package prettier-js
  :defer t
  :hook ((css-mode
          css-ts-mode
          markdown-mode
          php-mode
          php-ts-mode
          scss-mode
          tsx-ts-mode
          typescript-mode
          typescript-ts-mode
          vue-mode) . (prettier-js-mode t)))

(defun mode--config-ts-mode ())

(use-package typescript-ts-mode
  :defer t
  :config (mode--config-ts-mode))

(provide 'mode-ts)
