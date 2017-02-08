;;; fixmee-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "fixmee" "fixmee.el" (22683 17919 716870 488000))
;;; Generated autoloads from fixmee.el

(let ((loads (get 'fixmee 'custom-loads))) (if (member '"fixmee" loads) nil (put 'fixmee 'custom-loads (cons '"fixmee" loads))))

(let ((loads (get 'fixmee-global 'custom-loads))) (if (member '"fixmee" loads) nil (put 'fixmee-global 'custom-loads (cons '"fixmee" loads))))

(let ((loads (get 'fixmee-keys 'custom-loads))) (if (member '"fixmee" loads) nil (put 'fixmee-keys 'custom-loads (cons '"fixmee" loads))))

(defalias 'fixmee 'fixmee-goto-nextmost-urgent)

(autoload 'fixmee-mode "fixmee" "\
Turn on `fixmee-mode'.

When called interactively with no prefix argument this command
toggles the mode.  With a prefix argument, it enables the mode
if the argument is positive and otherwise disables the mode.

When called from Lisp, this command enables the mode if the
argument is omitted or nil, and toggles the mode if the argument
is 'toggle.

\(fn &optional ARG)" t nil)

(defvar global-fixmee-mode nil "\
Non-nil if Global-Fixmee mode is enabled.
See the command `global-fixmee-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-fixmee-mode'.")

(custom-autoload 'global-fixmee-mode "fixmee" nil)

(autoload 'global-fixmee-mode "fixmee" "\
Toggle Fixmee mode in all buffers.
With prefix ARG, enable Global-Fixmee mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Fixmee mode is enabled in all buffers where
`fixmee-maybe-turn-on' would do it.
See `fixmee-mode' for more information on Fixmee mode.

\(fn &optional ARG)" t nil)

(autoload 'fixmee-view-listing "fixmee" "\
View \"fixme\" notices in a `fixmee--listview-mode' buffer.

If the listview buffer currently exists, pop to it; otherwise
create it.

The listview buffer represents a snapshot of the current state
and does not update dynamically as you edit other
buffers.  (Other fixmee navigation commands such as
`fixmee-goto-nextmost-urgent' update and act according to
your latest edits.)

To regenerate the listview, issue this command with universal
prefix ARG.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil nil ("fixmee-pkg.el") (22683 17919 721971 884000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; fixmee-autoloads.el ends here
