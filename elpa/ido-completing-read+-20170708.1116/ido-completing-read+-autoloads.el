;;; ido-completing-read+-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "ido-completing-read+" "ido-completing-read+.el"
;;;;;;  (22883 34924 969447 512000))
;;; Generated autoloads from ido-completing-read+.el

(defvar ido-cr+-minibuffer-depth -1 "\
Minibuffer depth of the most recent ido-cr+ activation.

If this equals the current minibuffer depth, then the minibuffer
is currently being used by ido-cr+, and ido-cr+ feature will be
active. Otherwise, something else is using the minibuffer and
ido-cr+ features will be deactivated to avoid interfering with
the other command.

This is set to -1 by default, since `(minibuffer-depth)' should
never return this value.")

(defvar ido-cr+-replace-completely nil "\
If non-nil, replace `ido-completeing-read' completely with ido-cr+.

Enabling this may interfere with or cause errors in other
packages that use `ido-completing-read'. If you discover any such
incompatibilities, please file a bug report at
https://github.com/DarwinAwardWinner/ido-ubiquitous/issues")

(custom-autoload 'ido-cr+-replace-completely "ido-completing-read+" t)

(defsubst ido-cr+-active nil "\
Returns non-nil if ido-cr+ is currently using the minibuffer." (>= ido-cr+-minibuffer-depth (minibuffer-depth)))

(autoload 'ido-completing-read+ "ido-completing-read+" "\
ido-based method for reading from the minibuffer with completion.

See `completing-read' for the meaning of the arguments.

This function is a wrapper for `ido-completing-read' designed to
be used as the value of `completing-read-function'. Importantly,
it detects edge cases that ido cannot handle and uses normal
completion for them.

\(fn PROMPT COLLECTION &optional PREDICATE REQUIRE-MATCH INITIAL-INPUT HIST DEF INHERIT-INPUT-METHOD)" nil nil)

(defadvice ido-completing-read (around ido-cr+ activate) "\
This advice is the implementation of `ido-cr+-replace-completely'." (when (not (featurep (quote ido-completing-read+))) (require (quote ido-completing-read+))) (if (or (ido-cr+-active) (not ido-cr+-replace-completely)) ad-do-it (setq ad-return-value (apply (function ido-completing-read+) (ad-get-args 0)))))

(defadvice call-interactively (around ido-cr+-record-command-name activate) "\
Record the command being interactively called.

See `ido-cr+-current-command'." (let ((ido-cr+-current-command (ad-get-arg 0))) ad-do-it))

(defvar ido-context-switch-command nil "\
Variable holding the command used for switching to another completion mode.

This variable is originally declared in `ido.el', but it is not
given a value (or a docstring). This documentation comes from a
re-declaration in `ido-completing-read+.el' that initializes it
to nil, which should suppress some byte-compilation warnings in
Emacs 25. Setting another package's variable is not safe in
general, but in this case it should be, because ido always
let-binds this variable before using it, so the initial value
shouldn't matter.")

(defvar ido-ubiquitous-mode nil "\
Non-nil if Ido-Ubiquitous mode is enabled.
See the command `ido-ubiquitous-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `ido-ubiquitous-mode'.")

(custom-autoload 'ido-ubiquitous-mode "ido-completing-read+" nil)

(autoload 'ido-ubiquitous-mode "ido-completing-read+" "\
Use ido completion instead of standard completion almost everywhere.

If this mode causes problems for a function, you can customize
when ido completion is or is not used by customizing
`ido-cr+-function-blacklist'.

\(fn &optional ARG)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; ido-completing-read+-autoloads.el ends here
