(add-hook 'inf-ruby-mode-hook (lambda () (company-mode -1)))
(setq ruby-insert-encoding-magic-comment nil)
(setq ruby-align-chained-calls 1)
(define-key ruby-mode-map (kbd "C-c '") #'cycle-quotes)
(define-key ruby-mode-map (kbd "C-c M-j")
  (lambda ()
    (interactive)
    (run-ruby "bundle exec rails console development"
              "rails")))
(put 'flycheck-ruby-rubocop-executable
     'safe-local-variable
     (lambda (x)
       (member x '("rubocop" "bundle-exec-rubocop.sh" "bundle exec rubocop"))))
(defun endless/ruby-setup ()
  (setq-local
   compile-command
   '(ignore-errors
      (format "cd %s && bundle exec rspec %s"
              (shell-quote-argument (projectile-project-root))
              (shell-quote-argument
               (let ((file-name (buffer-file-name)))
                 (if (projectile-test-file-p file-name)
                     file-name
                   (projectile-find-matching-test file-name))))))))
(add-hook 'ruby-mode-hook #'endless/ruby-setup)
(add-hook 'ruby-mode-hook #'robe-mode)
(require 'smartparens-config)
(require 'smartparens-ruby)
(add-hook 'ruby-mode-hook #'smartparens-mode)

(add-hook 'ruby-mode-hook
          (lambda () (hs-minor-mode)))

(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . css-mode))
(add-to-list 'auto-mode-alist '("\\.arb\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.builder\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.env\\'" . sh-mode))
(setq-default web-mode-auto-close-style 2)
(setq-default web-mode-markup-indent-offset 2)

(eval-after-load "hideshow"
  '(add-to-list 'hs-special-modes-alist
                `(ruby-mode
                  ,(rx (or "def" "class" "module" "do" "{" "[" "case")) ; Block start
                  ,(rx (or "}" "]" "end"))                       ; Block end
                  ,(rx (or "#" "=begin"))                        ; Comment start
                  ruby-forward-sexp nil)))

(global-set-key (kbd "C-c h") 'hs-hide-block)
(global-set-key (kbd "C-c s") 'hs-show-block)

(require 'noflet)

(defadvice compilation-start (around inhibit-display
                                     (command &optional mode name-function highlight-regexp))
  "Hides compilation buffer."
  (if (not (string-match "^\\(find\\|ag\\|grep\\)" command))
      (noflet ((display-buffer 'ignore)
               (set-window-point 'ignore)
               (goto-char 'ignore))
        (fset 'display-buffer 'ignore)
        (fset 'set-window-point 'ignore)
        (fset 'goto-char 'ignore)
        (save-window-excursion
          ad-do-it))
    ad-do-it))

(define-key ruby-mode-map (kbd "C-c c") #'rubocop-autocorrect-current-file)

;; Fixes pry in rspec-compilation mode
(add-hook 'compilation-filter-hook 'inf-ruby-auto-enter)

;; Fixes cucumber paths
(setq feature-step-search-path "features/**/*.rb")

(provide 'setup-ruby)
;;; setup-ruby.el ends here
