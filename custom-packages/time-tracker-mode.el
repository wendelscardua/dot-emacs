;;; time-tracker-mode.el --- Helpers for Time Tracking

;; Copyright (C) 2019 Wendel Scardua
;; <wendel@scardua.net>

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.

;; You should have received a copy of the GNU General Public
;; License along with this program; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
;; MA 02111-1307 USA

;;; Commentary:

;; Introduction
;; ============

;; Helps tracking time.

;; Installation
;; ============

;; Place this file in your load path; then, place the following
;; command somewhere in your initialization file:

;; (require 'time-tracker)

;;; Code:

;;;(defun wendel-magit/open-pull-request ()
;;;  "Opens a pull request for current branch on Github."
;;;  (interactive)
;;;  (browse-url
;;;   (format "%s/pull/new/%s"
;;;           (replace-regexp-in-string
;;;            "[.]git$"
;;;            ""
;;;            (magit-get "remote"
;;;                       (magit-get-push-remote)
;;;                       "url"))
;;;           (magit-get-current-branch))))

(defun time-tracker-minutify (hours-and-minutes)
  "Convert HOURS-AND-MINUTES in minutes."
  (let* ((pair (split-string hours-and-minutes ":"))
         (hours (string-to-number (car pair)))
         (minutes (string-to-number (car (cdr pair)))))
    (+ (* hours 60) minutes)
    )
  )

(defun time-tracker-calculate ()
  "Calculates time in current buffer."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let ((total 0) (minute-signal -1))
      (while (not (eobp))
        (let* ((line (buffer-substring (point)
                                       (progn (forward-line 1) (point))))
               (minutes (seq-map #'time-tracker-minutify (cdr (split-string (replace-regexp-in-string "\s*#.*$" "" line) " ")))))
          (if (= (length minutes) 4)
              (progn
                (setq total (- total 480))
                (seq-doseq (minute minutes)
                  (setq total (+ total (* minute-signal minute)))
                  (setq minute-signal (* -1 minute-signal))
                  )))))
      (message "Total time: %s%02d:%02d"
               (if (< total 0) "-" "+")
               (/ (abs total) 60)
               (% (abs total) 60)))))

(defvar time-tracker-mode-hook nil)
(defvar time-tracker-mode-map
  (let ((map (make-keymap)))
    (define-key map "\C-t" 'time-tracker-calculate)
    map)
  "Keymap for Time Tracker major mode.")

(add-to-list 'auto-mode-alist '("\\.track\\'" . time-tracker-mode))

(defvar time-tracker-mode-syntax-table
  (let ((st (make-syntax-table)))
    st)
  "Time Tracker mode syntax table.")

(defvar time-tracker-font-lock-keywords
  (list
   '("\\<\\d\\d:\\d\\d\\>" . font-lock-string-face)
   '("\\<\\d\\d:\\>" . font-lock-constant-face)
   '("\\<#.*$" . font-lock-comment-face))
  "Highlighting expressions for time tracker mode.")

(defun time-tracker-mode ()
  "Major mode for personal Time Tracking."
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table time-tracker-mode-syntax-table)
  (use-local-map time-tracker-mode-map)
  (set (make-local-variable 'font-lock-defaults) '(time-tracker-font-lock-keywords))
  (setq major-mode 'time-tracker-mode)
  (setq mode-name "Time Tracker")
  (run-hooks 'time-tracker-mode-hook))

(provide 'time-tracker-mode)
;;; time-tracker-mode.el ends here
