;;; button-lock-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "button-lock" "button-lock.el" (22683 17919
;;;;;;  20875 797000))
;;; Generated autoloads from button-lock.el

(let ((loads (get 'button-lock 'custom-loads))) (if (member '"button-lock" loads) nil (put 'button-lock 'custom-loads (cons '"button-lock" loads))))

(autoload 'button-lock-button-properties "button-lock" "\
Return list of properties for BUTTON.

\(fn BUTTON)" nil nil)

(autoload 'button-lock-button-p "button-lock" "\
Return t if BUTTON is a button-lock button.

\(fn BUTTON)" nil nil)

(autoload 'button-lock-button-pattern "button-lock" "\
Return pattern for BUTTON.

\(fn BUTTON)" nil nil)

(autoload 'button-lock-button-grouping "button-lock" "\
Return grouping for BUTTON.

\(fn BUTTON)" nil nil)

(autoload 'button-lock-find-extent "button-lock" "\
Find the extent of a button-lock property around some point.

POS defaults to the current point.  PROPERTY defaults to
'button-lock.

Returns a cons in the form (START . END), or nil if there
is no such PROPERTY around POS.

\(fn &optional POS PROPERTY)" nil nil)

(autoload 'button-lock-mode "button-lock" "\
Toggle button-lock-mode, a minor mode for making text clickable.

Button-lock uses `font-lock-mode' to create and maintain its text
properties.  Therefore this mode can only be used where
`font-lock-mode' is active.

`button-lock-set-button' may be called to create a new button.
`button-lock-clear-all-buttons' may be called to clear all button
definitions in a buffer.

When called interactively with no prefix argument, this command
toggles the mode. When called interactively, with a prefix
argument, it enables the mode if the argument is positive and
otherwise disables it.  When called from Lisp, it enables the
mode if the argument is omitted or nil, and toggles the mode if
the argument is 'toggle.

\(fn &optional ARG)" t nil)

(defvar global-button-lock-mode nil "\
Non-nil if Global-Button-Lock mode is enabled.
See the command `global-button-lock-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-button-lock-mode'.")

(custom-autoload 'global-button-lock-mode "button-lock" nil)

(autoload 'global-button-lock-mode "button-lock" "\
Toggle Button-Lock mode in all buffers.
With prefix ARG, enable Global-Button-Lock mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Button-Lock mode is enabled in all buffers where
`button-lock-maybe-turn-on' would do it.
See `button-lock-mode' for more information on Button-Lock mode.

\(fn &optional ARG)" t nil)

(autoload 'button-lock-set-button "button-lock" "\
Attach mouse actions to text via `font-lock-mode'.

Required argument PATTERN is a regular expression to match.

Required argument ACTION is a function to call when the matching
text is clicked.  A quoted function name or a lambda expression
may be given.  The function called by ACTION must be interactive.
If ACTION is not valid the user may experience a silent failure.

If the function called by ACTION uses (interactive \"e\") it may
receive the relevant mouse event.  Note that you may wish to use
the mouse event to reposition the point.

ACTION may alternatively contain a prepared keymap, in which case
the convenience parameters :MOUSE-BINDING, :KEYBOARD-BINDING,
and :KEYBOARD-ACTION will be ignored.

Following PATTERN and ACTION is a Common Lisp-style series of
keyword/value arguments:

Setting :NO-REPLACE causes the function to have no effect when
a button already exists using the given PATTERN.  By default,
any existing button using PATTERN will be replaced.

:FACE is a font face to set on matching text, like hi-lock mode.
By default, :FACE has no properties, and :FACE-POLICY is :APPEND.
This means that other, existing text properties will take
priority, and that clickable text will not be distinguished
without a mouseover.  To change this, try adding the arguments
\":face 'link :face-policy 'prepend.\" Alternatively,
`button-lock-face' may be customized.

:MOUSE-FACE is the font face to set on mouseovers.  It defaults
to `button-lock-mouse-face'.

:FACE-POLICY sets the override policy for button faces.  Useful
values are nil, 'keep, 'prepend, and 'append (the default).  See
the documentation for OVERRIDE in `font-lock-keywords'.

:HELP-ECHO is applied to the 'help-echo text property, and may
become visible in a tooltip depending on your Emacs setup.
:HELP-TEXT is a deprecated synonym.

:KBD-HELP is applied to the 'kbd-help text property, accessible
to the user via `display-local-help',

:KBD-HELP-MULTILINE is applied to the non-standard
'kbd-help-multiline text property.

:GROUPING designates a subgroup in the pattern match to receive
the new text properties.  Subgroups, delimited by parentheses,
are numbered from 1.  The default :GROUPING is 0, indicating the
entire match.

:MOUSE-BINDING sets the mouse event which will invoke ACTION.
The default is 'mouse-1.

:KEYBOARD-BINDING sets a keyboard event which will invoke ACTION.
The format is as accepted by `kbd'.  The default is nil, meaning
no keyboard binding is in effect.  If this is set, it might also
be wise to alert the user by setting :FACE.  Note, the only
difference between :MOUSE-BINDING and :KEYBOARD-BINDING is
that :KEYBOARD-BINDING is interpreted by `kbd'.  It is possible
to pass keyboard events into :MOUSE-BINDING and vice versa.

:KEYBOARD-ACTION is an alternate event to be run by
:KEYBOARD-BINDING.  The default is nil, meaning that
:KEYBOARD-BINDING will invoke ACTION.  This is intended for cases
where ACTION is dependent on the position of the mouse.

:ADDITIONAL-PROPERTY defines an arbitrary text property which
will be set to t in for text which matches PATTERN, as optionally
modified by :GROUPING. The property 'button-lock will always be
set.

As a convenience, :MOUSE-2 through :MOUSE-5 can be used to attach
an alternate ACTION, as can :M-MOUSE-1 ..., :A-MOUSE-1 ...,
:DOUBLE-MOUSE-1 ..., :WHEEL-UP..., and :WHEEL-DOWN... The list is not
exhaustive.  For a general method of adding alternate bindings, pass
a keymap for :ACTION or use `button-lock-extend-binding'.

If :REAR-STICKY is non-nil, the rear-nonsticky text property will
not be added, as it is by default.  Changing this setting is not
recommended.

If :REMOVE is non-nil, any existing button using PATTERN will
be removed and forgotten by font-lock.

If successful, this function returns the button which was added
or removed from `font-lock-keywords'. Otherwise it returns nil.
The button value can be passed to `button-lock-extend-binding'.

\(fn PATTERN ACTION &key (face (quote button-lock-face)) (mouse-face (quote button-lock-mouse-face)) (face-policy (quote append)) HELP-ECHO HELP-TEXT KBD-HELP KBD-HELP-MULTILINE (grouping 0) (mouse-binding (quote mouse-1)) KEYBOARD-BINDING KEYBOARD-ACTION ADDITIONAL-PROPERTY REAR-STICKY REMOVE NO-REPLACE MOUSE-2 MOUSE-3 MOUSE-4 MOUSE-5 WHEEL-DOWN WHEEL-UP DOWN-MOUSE-1 DOWN-MOUSE-2 DOWN-MOUSE-3 DOWN-MOUSE-4 DOWN-MOUSE-5 DOUBLE-MOUSE-1 DOUBLE-MOUSE-2 DOUBLE-MOUSE-3 DOUBLE-MOUSE-4 DOUBLE-MOUSE-5 TRIPLE-MOUSE-1 TRIPLE-MOUSE-2 TRIPLE-MOUSE-3 TRIPLE-MOUSE-4 TRIPLE-MOUSE-5 A-MOUSE-1 A-MOUSE-2 A-MOUSE-3 A-MOUSE-4 A-MOUSE-5 A-WHEEL-DOWN A-WHEEL-UP C-MOUSE-1 C-MOUSE-2 C-MOUSE-3 C-MOUSE-4 C-MOUSE-5 C-WHEEL-DOWN C-WHEEL-UP M-MOUSE-1 M-MOUSE-2 M-MOUSE-3 M-MOUSE-4 M-MOUSE-5 M-WHEEL-DOWN M-WHEEL-UP S-MOUSE-1 S-MOUSE-2 S-MOUSE-3 S-MOUSE-4 S-MOUSE-5 S-WHEEL-DOWN S-WHEEL-UP S-MOUSE-1 S-MOUSE-2 S-MOUSE-3 S-MOUSE-4 S-MOUSE-5 S-WHEEL-DOWN S-WHEEL-UP)" nil nil)

(autoload 'button-lock-unset-button "button-lock" "\
Equivalent to running `button-lock-set-button' with :REMOVE set to true.

The syntax is otherwise identical to `button-lock-set-button',
which see.

A single argument BUTTON object may also be passed, which was returned
from `button-lock-set-button'.

\(fn &rest BUTTON)" nil nil)

(autoload 'button-lock-extend-binding "button-lock" "\
Add a binding to an existing button.

The principal button creation function `button-lock-set-button'
accepts only a limited subset of mouse bindings when binding
multiple actions.  This function supports arbitrary key bindings
for binding additional actions on a button.

EXISTING-BUTTON is a button value as returned by
`button-lock-set-button'.

ACTION, MOUSE-BINDING and KEYBOARD-BINDING are as documented in
`button-lock-set-button'.  It is possible to pass a nil
MOUSE-BINDING in order to set only a KEYBOARD-BINDING.

When passing a prepared keymap for ACTION, set MOUSE-BINDING
to nil.

\(fn EXISTING-BUTTON ACTION MOUSE-BINDING &optional KEYBOARD-BINDING)" nil nil)

(autoload 'button-lock-clear-all-buttons "button-lock" "\
Remove and deactivate all button-lock buttons in the buffer.

If FORCE is non-nil, try to remove buttons even when the minor
mode is not active.

\(fn)" t nil)

(autoload 'button-lock-register-global-button "button-lock" "\
Register a global button-lock button definition.

Arguments follow the form of `button-lock-set-button'.

The BUTTON defined here will applied each time the button-lock
minor mode is activated in a buffer.

To see an effect in any given buffer, button-lock mode must be
deactivated and reactivated.

\(fn &rest BUTTON)" nil nil)

(autoload 'button-lock-unregister-global-button "button-lock" "\
Remove global button-lock BUTTON.

Arguments follow the form of `button-lock-set-button'.

To see an effect in any given buffer, button-lock mode must be
deactivated and reactivated.

\(fn &rest BUTTON)" nil nil)

(autoload 'button-lock-unregister-all-global-buttons "button-lock" "\
Remove all global button-lock buttons definitions.

To see an effect in any given buffer, button-lock mode must be
deactivated and reactivated.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("button-lock-pkg.el") (22683 17919 23417
;;;;;;  200000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; button-lock-autoloads.el ends here
