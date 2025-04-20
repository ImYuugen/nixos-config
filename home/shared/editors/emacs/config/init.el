;; -*- coding: utf-8; lexical-binding: t -*-

;; Paths
(add-to-list 'load-path "~/.emacs.d/features")
(add-to-list 'load-path "~/.emacs.d/preferences")
(add-to-list 'load-path "~/.emacs.d/themes")

;; Features
(require 'feat-ace-window)
(require 'feat-avy)
(require 'feat-centaur-tabs)
(require 'feat-completion)
(require 'feat-meow)
(require 'feat-zoxide)

;; Prefs
(require 'pref-bars)
(require 'pref-bell)
(require 'pref-buffers)
(require 'pref-custom)
(require 'pref-font)
(require 'pref-linum)
(require 'pref-margin)
(require 'pref-saving)
(require 'pref-tabs)

;; Themes
(require 'theme-catppuccin)
