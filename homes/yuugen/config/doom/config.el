;;; config.el -*- lexical-binding: t; -*-

(setq display-line-numbers-type 'relative)

(setq doom-font                 (font-spec :family "Moralerspace Argon NF" :size 16)
      doom-variable-pitch-font  (font-spec :family "Moralerspace Argon NF" :size 18)
      doom-serif-font           (font-spec :family "Moralerspace Xenon NF" :size 16)
      doom-symbol-font          (font-spec :family "Noto Color Emoji" :size 16)
      doom-big-font-increment   4
      nerd-icons-font-names     '("SymbolsNerdFontMono-Regular.ttf"))

(after! (projectile meow)
  (setq projectile-project-search-path `(("~/Projects" . 2)))
  (meow-leader-define-key
   '("p s p" . projectile-switch-project)
   ;; Searching
   '("p s f" . projectile-find-file)
   '("p s g" . projectile-ripgrep)
   '("p s r" . projectile-replace)
   '("p s R" . projectile-replace-regexp)
   '("p f r" . projectile-find-references)
   ;;
   '("p c" . projectile-commander)
   ;; Toggle
   '("p t t" . projectile-toggle-between-implementation-and-test)
   '("p t h" . projectile-find-related-file)
   ;; Shell
   '("p !" . projectile-run-shell-command-in-root)
   '("p &" . projectile-run-async-shell-command-in-root)
   ;; Actions
   '("p a c" . projectile-compile-project)
   '("p a t" . projectile-test-project)
   '("p a i" . projectile-install-project)
   '("p a r" . projectile-run-project)
   ;; Buffers
   '("b b" . projectile-ibuffer)
   '("p b b" . projectile-ibuffer-by-project)
   '("p b K" . projectile-kill-buffers)
   '("p b S" . projectile-save-project-buffers)))

(after! (magit meow)
  (setq magit-diff-refine-hunk 'all
        magit-revision-show-gravatars '("^Author:     " . "^Commit:     "))
  (meow-leader-define-key
   '("g g" . magit)
   '("g l" . magit-log)
   '("g m" . magit-merge)
   '("g d" . magit-diff)))

(after! (avy meow)
  (meow-leader-define-key
   '("a g c" . avy-goto-char-2)
   '("a g w" . avy-goto-word-1)
   '("a k l" . avy-kill-whole-line)
   '("a k L" . avy-kill-ring-save-whole-line)
   '("a k r" . avy-kill-region)
   '("a k R" . avy-kill-ring-save-region)
   '("a m l" . avy-move-line)
   '("a m r" . avy-move-region)
   '("a y l" . avy-copy-line)
   '("a y r" . avy-copy-region)))

(after! (centaur-tabs meow)
  (setq centaur-tabs-set-close-button nil
        centaur-tabs-cycle-scope 'tabs)
  (meow-leader-define-key
   '("t a" . centaur-tabs-ace-jump)
   '("t h" . centaur-tabs-backward-tab)
   '("t H" . centaur-tabs-backward)
   '("t l" . centaur-tabs-forward-tab)
   '("t L" . centaur-tabs-forward)
   ;; Groups
   '("t g g" . centaur-tabs-toggle-groups)
   '("t g h" . centaur-tabs-backward-group)
   '("t g l" . centaur-tabs-forward-group)
   '("t g j" . centaur-tabs-select-beg-tab)
   '("t g k" . centaur-tabs-select-end-tab)
   ;; Kill buffers
   '("t K K" . kill-current-buffer)
   '("t K g" . centaur-tabs-kill-all-buffers-in-current-group)
   '("t K o" . centaur-tabs-kill-other-buffers-in-current-group)
   '("t K m" . centaur-tabs-kill-match-buffers-in-current-group)
   '("t K M" . centaur-tabs-keep-match-buffers-in-current-group)))

(after! (treemacs meow)
  (meow-leader-define-key
   '("T" . +treemacs/toggle)))

(after! corfu
  ;; Use M-TAB to open the completion pop-up
  (setq corfu-auto nil))

(setq shell-file-name (executable-find "bash"))
(setq-default vterm-shell (executable-find "fish"))

(after! indent-bars
  (setq
   indent-bars-color '(highlight :face-bg t :blend 0.15)
   indent-bars-pattern "."
   indent-bars-width-frac 0.1
   indent-bars-pad-frac 0.1
   indent-bars-zigzag nil
   indent-bars-color-by-depth '(:regexp "outline-\\([0-9]+\\)" :blend 1) ; blend=1: blend with BG only
   indent-bars-highlight-current-depth '(:blend 0.5) ; pump up the BG blend on current
   indent-bars-display-on-blank-lines t))

;; Lang
(use-package! lsp-nix
  :defer t
  :custom
  (lsp-nix-nil-formatter ["nixfmt"])
  (lsp-nix-nil-max-mem 16384))

;; Better window split
(defun split-window-v-focus-right ()
  "Split window vertically and focus the new tab."
  (interactive)
  (select-window (split-window-vertically)))
(defun split-window-h-focus-below ()
  "Split window horizontally and focus the new tab."
  (interactive)
  (select-window (split-window-horizontally)))
(global-set-key (kbd "C-x 2") #'split-window-v-focus-right)
(global-set-key (kbd "C-x 3") #'split-window-h-focus-below)
(global-set-key (kbd "M-o") 'ace-window)

(setq doom-theme 'doom-everforest-hard)
