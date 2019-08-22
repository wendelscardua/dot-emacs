;; Customizations relating to editing a buffer.

;; Key binding to use "hippie expand" for text autocompletion
;; http://www.emacswiki.org/emacs/HippieExpand
(global-set-key (kbd "M-/") 'hippie-expand)

;; Lisp-friendly hippie expand
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

;; Highlights matching parenthesis
(show-paren-mode 1)

;; Highlight current line
(global-hl-line-mode 1)

;; Interactive search key bindings. By default, C-s runs
;; isearch-forward, so this swaps the bindings.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; Don't use hard tabs
(setq-default indent-tabs-mode nil)

;; When you visit a file, point goes to the last place where it
;; was when you previously visited the same file.
;; http://www.emacswiki.org/emacs/SavePlace
(require 'saveplace)
(setq-default save-place t)
;; keep track of saved places in ~/.emacs.d/places
(setq save-place-file (concat user-emacs-directory "places"))

;; Emacs can automatically create backup files. This tells Emacs to
;; put all backups in ~/.emacs.d/backups. More info:
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Backup-Files.html
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))
(setq auto-save-default nil)

(defun endless/comment-line-or-region (n)
  "Comment or uncomment current line and leave point after it.
With positive prefix, apply to N lines including current one.
With negative prefix, apply to -N lines above.
If region is active, apply to active region instead."
  (interactive "p")
  (if (use-region-p)
      (comment-or-uncomment-region
       (region-beginning) (region-end))
    (let ((range
           (list (line-beginning-position)
                 (goto-char (line-end-position n)))))
      (comment-or-uncomment-region
       (apply #'min range)
       (apply #'max range)))
    (forward-line 1)
    (back-to-indentation)))

(global-set-key (kbd "C-;") 'endless/comment-line-or-region)

;; yay rainbows!
(rainbow-delimiters-mode t)

;; use 2 spaces for tabs
(defun die-tabs ()
  (interactive)
  (set-variable 'tab-width 2)
  (mark-whole-buffer)
  (untabify (region-beginning) (region-end))
  (keyboard-quit))

;; company-mode
(global-company-mode 1)
(setq tab-always-indent 'complete)

(setq company-idle-delay 0.2)
(setq company-dabbrev-code-time-limit .2)
(setq company-dabbrev-code-everywhere t)
(setq company-dabbrev-code-other-buffers t)
;;; This makes TAB a little more useful.
(define-key company-active-map [tab] #'company-complete)

;; smartparens
(with-eval-after-load 'smartparens
  (define-key smartparens-mode-map "\M-)" #'sp-split-sexp)
  (define-key smartparens-mode-map "\M-0" #'sp-forward-sexp)
  (define-key smartparens-mode-map "\M-9" #'sp-backward-sexp)
  (define-key smartparens-mode-map "\C-\M-i" #'sp-forward-slurp-sexp)
  (define-key smartparens-mode-map "\C-\M-o" #'sp-forward-barf-sexp)
  (define-key smartparens-mode-map "\C-\M-n" #'sp-up-sexp)
  (define-key smartparens-mode-map "\C-\M-u" #'sp-backward-up-sexp)
  (define-key smartparens-mode-map "\M-I" #'sp-backward-slurp-sexp)
  (define-key smartparens-mode-map "\M-O" #'sp-backward-barf-sexp)
  (define-key smartparens-mode-map "\M-S" #'sp-splice-sexp-killing-backward)
  (define-key smartparens-mode-map "\C-k" #'sp-kill-hybrid-sexp)
  (define-key smartparens-mode-map "\M-k" #'sp-kill-sexp))


(require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c C->") 'mc/mark-all-dwim)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.

Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive)
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))
(global-set-key [home] 'smart-beginning-of-line)
(global-set-key "\C-a" 'smart-beginning-of-line)

(global-aggressive-indent-mode 1)
(add-to-list 'aggressive-indent-excluded-modes 'html-mode)

(unless (server-running-p)
  (server-start))

(require 'editorconfig)
(editorconfig-mode 1)

(require 'company-tabnine)
(add-to-list 'company-backends #'company-tabnine)
;; Run M-x company-tabnine-install-binary to install the TabNine binary for your system.

;; Trigger completion immediately.
(setq company-idle-delay 0)

;; Number the candidates (use M-1, M-2 etc to select completions).
(setq company-show-numbers t)

(undo-tree-mode 1)
(global-set-key (kbd "C-M--") 'undo-tree-visualize)

(provide 'editing)
;;; editing.el ends here
