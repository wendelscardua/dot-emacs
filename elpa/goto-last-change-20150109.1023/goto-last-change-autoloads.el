;;; goto-last-change-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "goto-last-change" "goto-last-change.el" (22967
;;;;;;  193 13718 457000))
;;; Generated autoloads from goto-last-change.el

(autoload 'goto-last-change "goto-last-change" "\
Set point to the position of the last change.
Consecutive calls set point to the position of the previous change.
With a prefix arg (optional arg MARK-POINT non-nil), set mark so \\[exchange-point-and-mark]
will return point to the current position.

\(fn &optional MARK-POINT MINIMAL-LINE-DISTANCE)" t nil)

;;;***

;;;### (autoloads nil nil ("goto-last-change-pkg.el") (22967 193
;;;;;;  54707 472000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; goto-last-change-autoloads.el ends here
