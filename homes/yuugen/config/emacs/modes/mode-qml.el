;;; -*- coding: utf-8; lexical-binding: t -*-

(defun feat--config-qml-mode ()
  (push '(qmlformat . ("qmlformat"
					   "n"
					   "--objects-spacing"
					   "--functions-spacing"
					   filepath))
		apheleia-formatters)
  (push '(qml-mode . qmlformat) apheleia-mode-alist)
  (add-to-list 'lsp-language-id-configuration '(qml-mode . "qml")))

(use-package qml-mode
  :after apheleia lsp-mode
  :mode "\\.qml\\'"
  :config (feat--config-qml-mode))

(provide 'mode-qml)
