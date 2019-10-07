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
    ("0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "53f97243218e8be82ba035ae34c024fd2d2e4de29dc6923e026d5580c77ff702" "8ed752276957903a270c797c4ab52931199806ccd9f0c3bb77f6f4b9e71b9272" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "5999e12c8070b9090a2a1bbcd02ec28906e150bb2cdce5ace4f965c76cf30476" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "52588047a0fe3727e3cd8a90e76d7f078c9bd62c0b246324e557dfa5112e0d0c" default)))
 '(feature-use-docker-compose nil)
 '(inhibit-startup-screen t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(js2-getprop-has-side-effects t)
 '(magit-todos-ag-args (quote ("--ignore /public")))
 '(magit-todos-mode t nil (magit-todos))
 '(package-selected-packages
   (quote
    (htmlize magit-todos fish-mode fasd diary-manager nginx-mode noflet js2-mode json-mode solarized-theme dimmer typescript-mode csharp-mode yaml-mode window-jump web-mode web-completion-data undo-tree twittering-mode tagedit spotify smex smartparens smart-mode-line-powerline-theme rubocop rspec-mode robe restclient-helm rainbow-mode rainbow-delimiters projectile-rails project-explorer paredit paradox neotree multiple-cursors multi-term minesweeper magit-gh-pulls magit-filenotify keyfreq highlight-indentation helm-projectile helm-ag goto-last-change gmail-message-mode gitignore-mode gitconfig-mode gitattributes-mode git-timemachine flycheck-clojure feature-mode expand-region exec-path-from-shell enh-ruby-mode emojify dockerfile-mode cycle-quotes copy-as-format company-restclient clojure-mode-extra-font-locking aggressive-indent ag ace-jump-mode 4clojure 2048-game)))
 '(paradox-github-token t t)
 '(rubocop-autocorrect-on-save t)
 '(safe-local-variable-values
   (quote
    ((magit-todos-exclude-globs "*.html" "*.erb" "*.js" "*.map" "*.svg")
     (encoding . utf-8))))
 '(tls-checktrust t))

(let ((uninstalled-packages
       (seq-filter (lambda (package) (not (package-installed-p package))) package-selected-packages)))
  (if uninstalled-packages
      (progn
        (package-refresh-contents)
        (dolist (package uninstalled-packages)
          (package-install package)))))

(add-to-list 'load-path "~/.emacs.d/customizations")
(add-to-list 'load-path "~/.emacs.d/custom-packages")

;; Loads custom packages
(load "dedicate-windows-manually.el")
(load "magit-helpers.el")
(load "time-tracker-mode.el")
(load "org-protocol-github-lines.el")

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

(setq-default shell-file-name "/bin/bash")

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
