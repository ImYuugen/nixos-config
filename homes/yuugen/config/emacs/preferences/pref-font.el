;; -*- coding: utf-8; lexical-binding: t -*-

(defun font-exists-p (font)
  (if (null (x-list-fonts font)) nil t))
(when (window-system)
  (cond ((font-exists-p "Moralerspace Neon")
		 (set-frame-font "Moralerspace Neon:size=14" nil t))
		((font-exists-p "IosevkaNerdFontMono")
		 (set-frame-font "IosevkaNerdFontMono:size=14" nil t))))

(provide 'pref-font)
