(benchmark-init/activate)

(setq make-backup-files nil)
(global-visual-line-mode 1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)
(setq visible-bell t)
(setq ring-bell-function 'ignore)

(use-package catppuccin-theme
  :config
  (setopt catppuccin-flavor 'macchiato)
  (load-theme 'catppuccin :noconfirm))
(add-hook 'server-after-make-frame-hook #'catppuccin-reload)
(add-to-list 'default-frame-alist '(font . "Iosevka Nerd Font Mono"))

(setq indent-bars-color '(highlight :face-bg t :blend 0.15)
      indent-bars-pattern "."
      indent-bars-width-frac 0.1
      indent-bars-pad-frac 0.1
      indent-bars-zigzag nil
      indent-bars-color-by-depth '(:regexp "outline-\\([0-9]+\\)" :blend 1)
      indent-bars-highlight-current-depth '(:blend 0.5)
      indent-bars-display-on-blank-lines t)

(require 'org)
(org-babel-load-file (expand-file-name "keys.org" user-emacs-directory))
(org-babel-load-file (expand-file-name "modeline.org" user-emacs-directory))
(org-babel-load-file (expand-file-name "lsp.org" user-emacs-directory))

;; TODO
(use-package centaur-tabs
  :config
  (setq centaur-tabs-style "wave")
  (setq centaur-tabs-gray-out-icons 'buffer)
  (setq centaur-tabs-modified-marker t))

;; For command autocompletions
(setq vertico-count 20)
(vertico-mode)
(setq completion-styles '(orderless basic))
(keymap-set vertico-map "TAB" #'minibuffer-complete)
(marginalia-mode)

;; Extremely essential if you jump around flakes/shells
(direnv-mode)
(direnv-envrc-mode)

;; Pretty colors :3
(global-colorful-mode)

;; HACK: This is here to reload the current file, as filetype detection gets messed up on reload
(defun revert-all-file-buffers ()
  "Refreshes all open files"
  (interactive)
  (dolist (buf (buffer-list))
    (let ((filename (buffer-file-name)))
      (when (and filename (not (buffer-modified-p buf)))
	(if (file-readable-p filename)
	    (with-current-buffer buf
	      (revert-buffer-quick t))
	  (let (kill-buffer-query-functions)
	    (kill-buffer buf)
	    (message "Killed non-existing/unreadable file buffer: %s" filename))))))
  (message "Finished reverting buffers containing unmodified files."))
(revert-all-file-buffers)
