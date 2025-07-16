;;; -*- coding: utf-8; lexical-binding: t -*-

(use-package qml-mode
  :mode "\\.qml\\'")
(use-package apheleia
  :provide
  apheleia-formatters
  :config
  (push '(qmlformat . ("qmlformat"
					   "n"
					   "--objects-spacing"
					   "--functions-spacing"
					   filepath))
		apheleia-formatters)
  (push '(qml-mode . qmlformat)) apheleia-mode-alist)

(provide 'mode-qml)
