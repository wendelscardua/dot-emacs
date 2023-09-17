(require 'flycheck-cc65)

(add-hook 'c-mode-hook #'flycheck-cc65-setup)
