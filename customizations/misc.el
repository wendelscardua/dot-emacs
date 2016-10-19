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
(projectile-global-mode)

;; flycheck

(global-flycheck-mode)

;; magit
(global-set-key (kbd "C-c g s") 'magit-status)
(global-set-key (kbd "C-c g b") 'magit-blame)
(global-set-key (kbd "C-c g c") 'magit-checkout)
(global-set-key (kbd "C-c g r b") 'magit-rebase)

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

;; twittering-mode
(setq twittering-use-master-password t)
