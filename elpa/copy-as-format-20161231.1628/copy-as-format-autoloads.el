;;; copy-as-format-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "copy-as-format" "copy-as-format.el" (22634
;;;;;;  22346 892485 242000))
;;; Generated autoloads from copy-as-format.el

(autoload 'copy-as-format "copy-as-format" "\
Copy the current line or active region and add it to the kill ring as
GitHub/Slack/JIRA/HipChat/... formatted code. Format defaults to
`copy-as-format-default'. The buffer will not be modified.

With a prefix argument prompt for the format.

\(fn)" t nil)
(autoload 'copy-as-format-bitbucket "copy-as-format" nil t)
(autoload 'copy-as-format-disqus    "copy-as-format" nil t)
(autoload 'copy-as-format-github    "copy-as-format" nil t)
(autoload 'copy-as-format-gitlab    "copy-as-format" nil t)
(autoload 'copy-as-format-hipchat   "copy-as-format" nil t)
(autoload 'copy-as-format-html      "copy-as-format" nil t)
(autoload 'copy-as-format-jira      "copy-as-format" nil t)
(autoload 'copy-as-format-markdown  "copy-as-format" nil t)
(autoload 'copy-as-format-slack     "copy-as-format" nil t)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; copy-as-format-autoloads.el ends here
