(setq make-backup-files nil)
(global-visual-line-mode 1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)
(setq visible-bell t)
(setq ring-bell-function 'ignore)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
; Nothing ever happens
(setq custom-safe-themes t)
(load-theme 'rose-pine-color t nil)
(add-to-list 'default-frame-alist '(font . "Iosevka Nerd Font Mono"))

(require 'org)
(org-babel-load-file "~/.emacs.d/keys.org")
