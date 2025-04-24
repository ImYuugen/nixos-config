;;; darkman --- Manage dark and light themes based on the time of day -*- coding: utf-8; lexical-binding: t -*-
;;; Commentary:
;;; All credit goes to grtcdr for their darkman package
;;; My modifications are made so you can call arbitrary scripts instead of just theme names

;;; Code:
(require 'dbus)

(defvar darkman--dbus-service "nl.whynothugo.darkman")
(defvar darkman--dbus-path "/nl/whynothugo/darkman")
(defvar darkman--dbus-interface darkman--dbus-service)
(defvar darkman--dbus-signal nil)

(defgroup darkman nil
  "Darkman integration"
  :group 'convenience
  :prefix "darkman-")

(defun darkman--default-light-callback ()
  (message "Default light callback"))
(defun darkman--default-dark-callback ()
  (message "Default dark callback"))

(defcustom darkman-callbacks '(:light darkman--default-light-callback :dark darkman--default-dark-callback)
  "A property list which maps modes, `:light` and `:dark`, to their respective
callbacks."
  :type '(plist :key-type (choice (const :tag "Light callback" :light)
                                  (const :tag "Dark callback" :dark))
                :value-type function-type)
  :group 'darkman
  :package-version '(darkman . "0.1.0"))

(defcustom darkman-switch-silently t
  "When non-nil, suppress the message indicating the new mode."
  :type 'boolean
  :group 'darkman
  :package-version '(darkman . "0.1.0"))

(defun darkman-current-mode ()
  (interactive)
  (let ((mode (dbus-get-property
               :session
               darkman--dbus-service
               darkman--dbus-path
               darkman--dbus-interface
               "Mode")))
    (message "Darkman mode is %s." mode)
    mode))

(defun darkman-set-dark-callback (callback)
  "Sets the callback called when it's dark-time"
  (interactive)
  (plist-put darkman-callbacks :dark callback))

(defun darkman-set-light-callback (callback)
  "Sets the callback called when it's light-time"
  (interactive)
  (plist-put darkman-callbacks :light callback))

(defun darkman-set-mode (mode)
  (interactive "P Mode to set:")
  (dbus-set-property
   :session
   darkman--dbus-service
   darkman--dbus-path
   darkman--dbus-interface
   "Mode" (if (member mode '(dark light))
              (symbol-name mode)
            (darkman--invalid-mode-error mode))))

(defun darkman-exec-callback ()
  "Execute the callback assosciated with the current mode."
  (interactive)
  (let ((mode (darkman-current-mode)))
    (funcall (darkman--lookup-callback mode))))

(defun darkman--lookup-callback (mode)
  "Returns the callback associated with MODE."
  (cond ((cl-equalp mode "light") (plist-get darkman-callbacks :light))
        ((cl-equalp mode "dark") (plist-get darkman-callbacks :dark))))

(defun darkman--invalid-mode-error (mode)
  (error "'%s' is not a valid mode" mode))

(defun darkman--signal-handler (mode)
  (unless darkman-switch-silently
    (message "Darkman switched to %s mode." mode))
  (darkman-exec-callback))

(defun darkman--check-dbus-service ()
  "Return non-nil if \='darkman--dbus-service\=' is available."
  (or (dbus-ping :session darkman--dbus-service 1000)
      (error "%s D-Bus service not available" darkman--dbus-service)))

(define-minor-mode darkman-mode
  "Minor mode providing darkman integration."
  :global t
  :init-value nil
  :require 'dbus
  :group 'darkman
  :version "0.1.0"
  (if darkman-mode
      (unless (and darkman--dbus-signal
                   (not (darkman--check-dbus-service)))
        (setq darkman--dbus-signal
              (dbus-register-signal
               :session
               darkman--dbus-service
               darkman--dbus-path
               darkman--dbus-interface
               "ModeChanged"
               #'darkman--signal-handler))
        (darkman-exec-callback))
    (dbus-unregister-object darkman--dbus-signal)
    (setq darkman--dbus-signal nil)))


(darkman-mode)

(provide 'feat-darkman)
;;; feat-darkman.el ends here
