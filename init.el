(setq projectile-go-function #'projectile-go)
(require 'package)

(setq package-archives `(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-tab-width 2)
 '(custom-safe-themes
   (quote
    ("53f97243218e8be82ba035ae34c024fd2d2e4de29dc6923e026d5580c77ff702" "8ed752276957903a270c797c4ab52931199806ccd9f0c3bb77f6f4b9e71b9272" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "5999e12c8070b9090a2a1bbcd02ec28906e150bb2cdce5ace4f965c76cf30476" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "52588047a0fe3727e3cd8a90e76d7f078c9bd62c0b246324e557dfa5112e0d0c" default)))
 '(feature-use-docker-compose nil)
 '(inhibit-startup-screen t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
   (quote
    (dimmer monokai-theme color-theme-sanityinc-tomorrow typescript-mode csharp-mode yaml-mode xkcd window-jump web-mode web-completion-data undo-tree twittering-mode tangotango-theme tagedit spotify smex smartparens smart-mode-line-powerline-theme rubocop rspec-mode robe restclient-helm rainbow-mode rainbow-delimiters projectile-rails project-explorer pomidor paredit paradox neotree multiple-cursors multi-term minesweeper magit-gh-pulls magit-filenotify keyfreq highlight-indentation helm-projectile helm-ag goto-last-change gmail-message-mode gitignore-mode gitconfig-mode gitattributes-mode git-timemachine flycheck-clojure fixmee feature-mode expand-region exec-path-from-shell enh-ruby-mode emojify editorconfig edit-server dockerfile-mode cycle-quotes copy-as-format company-restclient clojure-mode-extra-font-locking aggressive-indent ag ace-jump-mode 4clojure 2048-game)))
 '(paradox-github-token t t)
 '(safe-local-variable-values (quote ((encoding . utf-8))))
 '(tls-checktrust t))

(add-to-list 'load-path "~/.emacs.d/customizations")
(add-to-list 'load-path "~/.emacs.d/custom-packages")

;; Loads custom packages
(load "dedicate-windows-manually.el")
(load "magit-helpers.el")

;; Sets up exec-path-from-shell so that Emacs will use the correct
;; environment variables
(load "shell-integration.el")

;; Secret things (e.g. github tokens)
(load "private.el")

;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer.
(load "navigation.el")

;; These customizations change the way emacs looks and disable/enable
;; some user interface elements
(load "ui.el")

;; These customizations make editing a bit nicer.
(load "editing.el")

;; Hard-to-categorize customizations
(load "miscelaneous.el")

;; For editing lisps
(load "elisp-editing.el")

;; Language-specific
(load "setup-clojure.el")

(with-eval-after-load 'ruby-mode
  (load "setup-ruby.el"))

(load "setup-js.el")

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'scroll-left 'disabled nil)
