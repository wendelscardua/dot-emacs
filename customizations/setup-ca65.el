(require 'ca65-mode)
(require 'flycheck-ca65)

(defun ca65-config ()
  "Configures ca65-mode stuff."
  (interactive)
  (setq tab-width 2))

(add-hook 'ca65-mode-hook #'flycheck-ca65-setup)
(add-hook 'ca65-mode-hook #'ca65-config)
