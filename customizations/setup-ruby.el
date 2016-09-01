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
(eval-after-load 'company
  '(push 'company-robe company-backends))
(add-hook 'ruby-mode-hook #'robe-mode)
(require 'smartparens-config)
(require 'smartparens-ruby)
(add-hook 'ruby-mode-hook #'smartparens-mode)

(add-hook 'ruby-mode-hook
  (lambda () (hs-minor-mode)))

(eval-after-load "hideshow"
  '(add-to-list 'hs-special-modes-alist
    `(ruby-mode
      ,(rx (or "def" "class" "module" "do" "{" "[" "case")) ; Block start
      ,(rx (or "}" "]" "end"))                       ; Block end
      ,(rx (or "#" "=begin"))                        ; Comment start
      ruby-forward-sexp nil)))

(global-set-key (kbd "C-c h") 'hs-hide-block)
(global-set-key (kbd "C-c s") 'hs-show-block)

(provide 'setup-ruby)
;;; setup-ruby.el ends here
