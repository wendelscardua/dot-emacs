(require 'ca65-mode)
(require 'flycheck-ca65)
(add-hook 'ca65-mode-hook #'flycheck-ca65-setup)
(defun ca65-config ()
  "Configures stuff for this mode."
  (setq-local tab-width 2))
(add-hook 'ca65-mode-hook #'ca65-config)
