;;; init --- My Emacs config :3 -*- coding: utf-8; lexical-binding: t -*-
;;; Commentary:
;;; Credits to enzuru for their cool Emacs config !

;;; Code:
;; Paths
(add-to-list 'load-path "~/.emacs.d/features")
(add-to-list 'load-path "~/.emacs.d/modes")
(add-to-list 'load-path "~/.emacs.d/preferences")
(add-to-list 'load-path "~/.emacs.d/themes")

(setq package-install-upgrade-built-in t)

;; Features
(require 'feat-ace-window)
(require 'feat-avy)
(require 'feat-centaur-tabs)
(require 'feat-completion)
(require 'feat-consult)
(require 'feat-darkman)
(require 'feat-direnv)
(require 'feat-doom-modeline)
(require 'feat-flycheck)
(require 'feat-indent-bars)
(require 'feat-magit)
(require 'feat-meow)
(require 'feat-projectile)
(require 'feat-treesitter)
(require 'feat-zoxide)

;; Modes
(require 'mode-elisp)
(require 'mode-nix)
(require 'mode-ts)

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
(require 'pref-which-key)

;; Themes
(require 'theme-catppuccin)

;;; init.el ends here
