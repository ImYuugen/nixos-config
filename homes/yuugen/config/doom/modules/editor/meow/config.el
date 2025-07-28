;;; editor/meow/config.el -*- lexical-binding: t; -*-

(use-package! meow

;;; Loading

  ;; Eager-load Meow, so that if there are errors later in our config, at least
  ;; we have Meow set up to fix them.
  :demand t

  ;; Enable after modules have loaded.
  :hook (doom-after-modules-config . meow-global-mode)

  :init

;;; `meow-motion-remap-prefix'

  ;; Rebind all keys shadowed by Meow's Motion state to 'C-<key>'.
  ;; Different from the Meow default 'H-<key>', because how many users actually
  ;; have that key on their keyboard?
  ;; 'C-j' and 'C-k' are unlikely to be rebound by any modes as they're basic
  ;; editing keys. 'C-]' can't be remapped under the 'C-' prefix, but it's
  ;; unlikely that any mode will shadow `abort-recursive-edit'.
  (setq meow-motion-remap-prefix "C-")

  :config

;;; Cursor configuration

  ;; In Emacs, unlike Evil, the cursor is /between/ two characters, not on top
  ;; of a character. Since this module will likely attract a lot of Evil users,
  ;; use the 'bar' cursor shape instead of the default 'block' to reflect this
  ;; fact.
  ;; In addition, blink the cursor in insert state.

  (defvar +meow-want-blink-cursor-in-insert t
    "Whether `blink-cursor-mode' should be enabled in INSERT state.")

  (setq meow-cursor-type-normal 'box
        meow-cursor-type-insert 'bar
        meow-cursor-type-beacon 'box
        meow-cursor-type-paren 'hollow
        meow-cursor-type-default 'box
        blink-cursor-delay 0 ; start blinking immediately
        blink-cursor-blinks 0 ; blink forever
        blink-cursor-interval 0.15) ; blink time period

  ;; Toggle blink on entering/exiting insert mode
  (add-hook 'meow-insert-mode-hook #'+meow-maybe-toggle-cursor-blink)

  ;; When we switch windows, the window we switch to may be in a different state
  ;; than the previous one
  (advice-add #'meow--on-window-state-change
              :after #'+meow-maybe-toggle-cursor-blink)

;;; Continuing commented lines

  ;; Since `meow-open-below' just runs `newline-and-indent', it will perform
  ;; Doom's behavior of continuing commented lines (if
  ;; `+default-want-RET-continue-comments' is non-nil). Prevent this.
  (defvar +meow-want-meow-open-below-continue-comments nil
    "If non-nil `meow-open-below' will continue commented lines.")

  (defadvice! +meow--newline-indent-and-continue-comments-a (&rest _)
    "Support `+meow-want-meow-open-below-continue-comments'.
Doom uses `+default--newline-indent-and-continue-comments-a' to continue
comments. Prevent that from running if necessary."
    :before-while #'+default--newline-indent-and-continue-comments-a
    (interactive "*")
    (if (eq real-this-command #'meow-open-below)
        +meow-want-meow-open-below-continue-comments
      t))


;;; Expansion hints
  ;; These should not be disabled anywhere by default; if users find that they
  ;; cause problems due to variable-width fonts etc., they can configure this
  ;; variable themselves.
  (setq meow-expand-exclude-mode-list nil)

;;; misc. settings

  ;; Wait for longer before removing the expansion hints. One second is too
  ;; short, especially for people using them for the first time.
  (setq meow-expand-hint-remove-delay 4.0)

  ;; Don't self-insert keypad-mode keys if they're undefined, in order to be
  ;; consistent with Emacs' standard behavior with undefined keys.
  (setq meow-keypad-self-insert-undefined nil)

  ;; Append after cursor
  (setq meow-use-cursor-position-hack t)

;;; Bindings

  ;; Disable C-M shortcut
  (setq meow-keypad-ctrl-meta-prefix nil)
  (setq meow-keypad-meta-prefix nil)

;;;; Suggested bindings

  (cond ((modulep! +qwerty) (+meow--setup-qwerty))
        ((modulep! +qwertz) (+meow--setup-qwertz))
        ((modulep! +dvorak) (+meow--setup-dvorak))
        ((modulep! +dvp) (+meow--setup-dvp))
        ((modulep! +colemak) (+meow--setup-colemak))
        (t nil))

;;;; Doom leader/localleader

  ;; FIXME: When these are invoked via Keypad, the descriptions of prefixes are
  ;; not shown. This could be a Doom problem, a general.el problem, or a
  ;; `meow--which-key-describe-keymap' problem.
  (when (modulep! :config default +bindings)

    ;; Doom uses a complicated system involving `general-override-mode' to set
    ;; up its leader and localleader keys. I don't pretend to understand how it
    ;; works. But as far as I can tell, we can rely on it to work in the
    ;; following way -
    ;; `doom-leader-alt-key' (default 'C-c') is treated as the leader key when
    ;; Doom's emacs bindings are in use, and all leader keybindings should be
    ;; accessible under this key.
    ;; So we can simply tell Meow to prefix the Keypad key sequence with 'C-c',
    ;; and all leader key bindings should be accessible when Keypad is invoked.
    ;; With `meow-keypad' bound to 'SPC' as expected, this parallels the
    ;; behavior in :editor evil.
    (setq meow-keypad-leader-dispatch "C-c")

    ;; A minor tweak - 'SPC c' will translate to 'C-c' rather than invoking
    ;; `doom-leader-code-map'. So we must use another prefix key. 'k' was chosen
    ;; because it wasn't already in use, and because it makes
    ;; `+lookup/documentation', a very handy command, easy to invoke
    ;; ('SPC k k').
    ;; (We need a hook since this module is loaded before the bindings are, due to ':demand')
    (add-hook! 'doom-after-modules-config-hook
      (defun +meow-leader-move-code-map-h ()
        (when (boundp 'doom-leader-code-map)
          (define-key doom-leader-map "k" (cons "code" doom-leader-code-map))
          ;; Unbind the 'c' prefix; we'll use it in our localleader hack.
          (define-key doom-leader-map "c" nil))))

    ;; Also note that the Git commands are now under 'SPC v', unlike in
    ;; :editor evil.

    ;; Next, the localleader. For non-Evil users, this is invoked by 'C-c l'.
    ;; Since 'l' isn't used as a prefix in `doom-leader-map', we can use it as
    ;; the prefix for localleader. ('SPC m' would translate to 'M-' in Keypad
    ;; state, so we can't use it.)
    ;; I do not understand how Doom accomplishes the localleader bindings and do
    ;; not want to tangle with general.el, so we'll accomplish this with a HACK.
    ;;
    ;; Doom binds `doom-leader-map' under 'C-c' (the default value of
    ;; `doom-leader-alt-key'. Ideally we want to bind locallleader under this
    ;; prefix as well. Since we just freed up the 'c' prefix in
    ;; `doom-leader-map', we use that -
    (add-hook! 'doom-after-modules-config-hook
      (defun +meow-set-localleader-alt-key-h ()
        (setq doom-localleader-alt-key "C-c c")))
    ;;
    ;; Then, we define a command that calls 'C-c c', and bind it to 'l':
    (define-key doom-leader-map "l"
                (cons "+localleader" (cmd! (meow--execute-kbd-macro "C-c c"))))
    ;; ...and now the localleader bindings are accessible with 'SPC l' (or with
    ;; 'SPC c SPC c', for that matter).
    )

;;;; Layout-independent Rebindings

;;;;; Keypad

;;;;;; SPC u -> C-u
  ;; Like in Doom's evil config.
  (define-key doom-leader-map "u" #'meow-universal-argument)

;;;;; 'M-SPC'

  ;; As in our EMACS state, make 'M-SPC' trigger the leader-key bindings in
  ;; Insert state.
  (meow-define-keys 'insert '("M-SPC" . meow-keypad))

;;;;; `+meow-escape'

  ;; By default, ESC does nothing in Meow normal state (bound to `ignore'). But
  ;; we need to run `doom-escape-hook' for things like :ui popup to function as
  ;; expected. In addition, it makes sense to extend `doom/escape's incremental
  ;; behavior to Meow.
  ;; Hence, `+meow-escape' - a command that cancels the selection if it's
  ;; active, otherwise falling back to `doom/escape'.
  ;; This also has the nice effect of requiring one less normal-state
  ;; keybinding - `meow-cancel-selection' is no longer needed as this command
  ;; invokes it when necessary, so the user can rebind 'g' if they want.
  (meow-normal-define-key '("<escape>" . +meow-escape))

;;;;; Esc in Motion state

  ;; Popups will be in Motion state, and Doom's popup management relies on
  ;; `doom-escape-hook'. So we can't have <escape> bound to `ignore'.
  (meow-motion-overwrite-define-key '("<escape>" . doom/escape))

;;;; Emacs tutorial
  ;; It teaches the default bindings, so make it start in our Emacs state.
  (defadvice! +meow-emacs-tutorial-a (&rest _)
    :after #'help-with-tutorial
    (+meow-toggle-emacs-state)
    (insert
     (propertize
      "Meow: this Tutorial buffer has been started in Emacs state. Meow
bindings are not active.\n\n"
      'face 'warning))))
