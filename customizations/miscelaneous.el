;; Changes all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

;; shell scripts
(setq-default sh-basic-offset 2)
(setq-default sh-indentation 2)

;; No need for ~ files when editing
(setq create-lockfiles nil)

;; Go straight to scratch buffer on startup
(setq inhibit-startup-message t)

;; Projectile (?)
(setq projectile-switch-project-action #'projectile-commander)
(projectile-mode)

;; flycheck

(global-flycheck-mode)

;; magit
(global-set-key (kbd "C-c g b") 'magit-blame)
(global-set-key (kbd "C-c g c") 'magit-checkout)
(global-set-key (kbd "C-c g d") 'magit-diff-buffer-file-popup)
(global-set-key (kbd "C-c g s") 'magit-status)
(global-set-key (kbd "C-c g t") 'git-timemachine)

(remove-hook 'magit-refs-sections-hook 'magit-insert-tags)
(remove-hook 'server-switch-hook 'magit-commit-diff)
(setq vc-handled-backends nil)

;; spotify
(global-set-key (kbd "<f9>") #'spotify-previous)
(global-set-key (kbd "<f10>") #'spotify-pause)
(global-set-key (kbd "<f11>") #'spotify-play)
(global-set-key (kbd "<f12>") #'spotify-next)

;; multi-term
(defun last-term-buffer (l)
  "Return most recently used term buffer."
  (when l
    (if (eq 'term-mode (with-current-buffer (car l) major-mode))
        (car l) (last-term-buffer (cdr l)))))

(defun get-term ()
  "Switch to the term buffer last used, or create a new one if
    none exists, or if the current buffer is already a term."
  (interactive)
  (let ((b (last-term-buffer (buffer-list))))
    (if (or (not b) (eq 'term-mode major-mode))
        (multi-term)
      (switch-to-buffer b))))

(global-set-key (kbd "C-c t") 'get-term)
(global-set-key (kbd "C-c <left>") 'multi-term-prev)
(global-set-key (kbd "C-c <right>") 'multi-term-next)

;; increment/decrement value in place
(defun wendel/increment-number (&optional arg)
  "Increment the number forward from point by ARG."
  (interactive "p*")
  (save-excursion
    (save-match-data
      (let (inc-by field-width answer)
        (setq inc-by (if arg arg 1))
        (skip-chars-backward "0123456789")
        (when (re-search-forward "[0-9]+" nil t)
          (setq field-width (- (match-end 0) (match-beginning 0)))
          (setq answer (+ (string-to-number (match-string 0) 10) inc-by))
          (when (< answer 0)
            (setq answer (+ (expt 10 field-width) answer)))
          (replace-match (format (concat "%0" (int-to-string field-width) "d")
                                 answer)))))))

(defun wendel/decrement-number (&optional arg)
  "Decrement the number forward from point by ARG."
  (interactive "p*")
  (wendel/increment-number (if arg (- arg) -1)))

(global-set-key (kbd "C-c +") 'wendel/increment-number)
(global-set-key (kbd "C-c -") 'wendel/decrement-number)

;; autofix changed files
(defun wendel/autofix-changed-files ()
  "Autocorrect changed files with linters (rubocop, eslint), if changed compared to upstream."
  (interactive)
  (require 'rubocop)
  (let ((original-directory default-directory))
    (cd (projectile-project-root))
    (let ((changed-files (magit-git-items "diff" "-z" "--name-only" (magit-get-upstream-ref))))
      (let ((ruby-files (seq-filter (lambda (x) (string-match "\.rb$" x)) changed-files))
            (js-files (seq-filter (lambda (x) (string-match "\.js$" x)) changed-files)))
        (if (> (length ruby-files) 0)
            (rubocop--dir-command rubocop-autocorrect-command (string-join ruby-files " ")))
        (if (> (length js-files) 0)
            (shell-command (concat "eslint --fix " (string-join js-files " "))))))
    (cd original-directory)))

(global-set-key (kbd "C-c x") #'wendel/autofix-changed-files)


;; twittering-mode
(setq twittering-use-master-password t)

;; auto revert
(auto-revert-mode)

;; open file at point
(global-set-key (kbd "C-<return>") 'find-file-at-point)
