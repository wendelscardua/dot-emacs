;; These customizations change the way emacs looks and disable/enable
;; some user interface elements. Some useful customizations are
;; commented out, and begin with the line "CUSTOMIZE". These are more
;; a matter of preference and may require some fiddling to match your
;; preferences

;;; Code:

;; Turn off the menu bar at the top of each frame because it's distracting
(menu-bar-mode -1)

;; Show line numbers
(global-linum-mode)

;; You can uncomment this to remove the graphical toolbar at the top. After
;; awhile, you won't need the toolbar.
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; Don't show native OS scroll bars for buffers because they're redundant
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Color Themes
;; Read http://batsov.com/articles/2012/02/19/color-theming-in-emacs-reloaded/
;; for a great explanation of emacs color themes.
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Custom-Themes.html
;; for a more technical explanation.
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")
;;(load-theme 'tomorrow-night-bright t)
(load-theme 'tangotango t)

;; increase font size for better readability
(set-face-attribute 'default nil :family "mononoki" :height 80)

;; Uncomment the lines below by removing semicolons and play with the
;; values in order to set the width (in characters wide) and height
;; (in lines high) Emacs will have whenever you start it
;; (setq initial-frame-alist '((top . 0) (left . 0) (width . 177) (height . 53)))

;; These settings relate to how emacs interacts with your operating system
(setq ;; makes killing/yanking interact with the clipboard
      x-select-enable-clipboard t

      ;; I'm actually not sure what this does but it's recommended?
      x-select-enable-primary t

      ;; Save clipboard strings into kill ring before replacing them.
      ;; When one selects something in another program to paste it into Emacs,
      ;; but kills something in Emacs before actually pasting it,
      ;; this selection is gone unless this variable is non-nil
      save-interprogram-paste-before-kill t

      ;; Shows all options when running apropos. For more info,
      ;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Apropos.html
      apropos-do-all t

      ;; Mouse yank commands yank at point instead of at click.
      mouse-yank-at-point t)

;; No cursor blinking, it's distracting
(blink-cursor-mode 0)

;; full path in title bar
(setq-default frame-title-format "%b (%f)")

;; don't pop up font menu
(global-set-key (kbd "s-t") '(lambda () (interactive)))

;; no bell
(setq ring-bell-function 'ignore)

;; prettify things
(global-prettify-symbols-mode +1)

;; (defconst endless/clojure-prettify-alist '())

;; (add-to-list 'endless/clojure-prettify-alist
             ;; '(">=" . ?≥))

;; (add-to-list 'endless/clojure-prettify-alist
             ;; '("<=" . ?≤))

;; (eval-after-load 'clojure-mode
;;   '(setq clojure--prettify-symbols-alist
;;          (append endless/clojure-prettify-alist
;;                  clojure--prettify-symbols-alist)))
;; (eval-after-load 'lisp-mode
;;   '(setq lisp--prettify-symbols-alist
;;          (append endless/clojure-prettify-alist
;;                  lisp--prettify-symbols-alist)))

;; mouse wheel & keyboard scroll one line at a time
;; scroll one line at a time (less "jumpy" than defaults)
    
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
    
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
    
(setq mouse-wheel-follow-mouse t) ;; scroll window under mouse

(setq scroll-step 1) ;; keyboard scroll one line at a time

;; turn off line wrap

(setq-default truncate-lines t)

;; powerline
;;(require 'powerline)
;;(powerline-default-theme)

(setq sml/theme 'powerline)
(sml/setup)

;; window navigation
(global-set-key (kbd "C-x <down>") 'window-jump-down)
(global-set-key (kbd "C-x <up>") 'window-jump-up)
(global-set-key (kbd "C-x <left>") 'window-jump-left)
(global-set-key (kbd "C-x <right>") 'window-jump-right)

;; ace-jump-mode
(global-set-key (kbd "C-.") 'ace-jump-mode)

(provide 'ui)
;;; ui.el ends here
