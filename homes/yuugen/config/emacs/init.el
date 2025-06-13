;;; init --- My Emacs config ;3 -*- coding: utf-8; lexical-binding: t -*-
;;; Commentary:
;;; Credits to enzuru. I basically stole the structure

;;; Code:

;; Paths
(setq root (file-name-directory (or load-file-name (buffer-file-name))))
(add-to-list 'load-path (concat root "features"))
(add-to-list 'load-path (concat root "modes"))
(add-to-list 'load-path (concat root "preferences"))
(add-to-list 'load-path (concat root "themes"))

(require 'pref-bars)
(require 'pref-bell)
(require 'pref-buffers)
(require 'pref-custom)
(require 'pref-font)
(require 'pref-linum)
(require 'pref-margin)
(require 'pref-saving)
(require 'pref-tabs)
(require 'pref-which-key)
