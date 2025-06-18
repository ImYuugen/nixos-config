;;; init --- My Emacs config ;3 -*- coding: utf-8; lexical-binding: t -*-
;;; Commentary:
;;; Credits to enzuru.  I basically stole the structure

;;; Code:

;; Paths
(defvar cache-dir (concat (getenv "HOME") "/.config/emacs/"))

(add-to-list 'load-path (concat user-emacs-directory "features"))
(add-to-list 'load-path (concat user-emacs-directory "modes"))
(add-to-list 'load-path (concat user-emacs-directory "preferences"))
(add-to-list 'load-path (concat user-emacs-directory "themes"))

(setq use-package-always-ensure t)

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

(require 'feat-ace-window)
(require 'feat-apheleia)
(require 'feat-avy)
(require 'feat-centaur-tabs)
(require 'feat-completion)
(require 'feat-direnv)
(require 'feat-doom-modeline)
(require 'feat-indent-bars)
(require 'feat-lsp)
(require 'feat-magit)
(require 'feat-meow)
(require 'feat-projectile)
(require 'feat-wakatime)

(require 'mode-nix)

(require 'theme-catppuccin)
