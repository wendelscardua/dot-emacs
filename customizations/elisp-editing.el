(add-hook 'emacs-lisp-mode-hook #'smartparens-mode)

(add-hook 'eval-expression-minibuffer-setup-hook #'smartparens-mode)
(add-hook 'ielm-mode-hook             #'smartparens-mode)
(add-hook 'lisp-mode-hook             #'smartparens-mode)
(add-hook 'lisp-interaction-mode-hook #'smartparens-mode)
(add-hook 'scheme-mode-hook           #'smartparens-mode)

;; eldoc-mode shows documentation in the minibuffer when writing code
;; http://www.emacswiki.org/emacs/ElDoc
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
