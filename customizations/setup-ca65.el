(require 'ca65-mode)
(require 'flycheck-ca65)
(add-hook 'ca65-mode-hook #'flycheck-ca65-setup)
