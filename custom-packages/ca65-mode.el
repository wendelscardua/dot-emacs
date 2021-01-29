;;; ca65-mode.el --- Major mode for editing ca65 assembly files

;; Copyright (C) 2019 Wendel Scardua
;; <wendel@scardua.net>

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.

;; You should have received a copy of the GNU General Public
;; License along with this program; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
;; MA 02111-1307 USA

;;; Commentary:

;; Introduction
;; ============

;; Major mode for editing ca65 assembly files

;; Installation
;; ============

;; Place this file in your load path; then, place the following
;; command somewhere in your initialization file:

;; (require 'ca65-mode)

;;; Code:

(defvar ca65-mode-hook nil)

(defvar ca65-mode-map
  (let ((map (make-keymap)))
    (define-key map "\C-j" 'newline-and-indent)
    map)
  "Keymap for ca65 major mode.")

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.s\\'" . ca65-mode))
(add-to-list 'auto-mode-alist '("\\.inc\\'" . ca65-mode))

(defconst ca65-font-lock-keywords-1
  (list
   '("\\<\\(A\\(?:DC\\|ND\\|SL\\)\\|B\\(?:C[CS]\\|EQ\\|IT\\|MI\\|NE\\|PL\\|RK\\|V[CS]\\)\\|C\\(?:L[CDIV]\\|MP\\|P[XY]\\)\\|DE[CXY]\\|EOR\\|IN[CXY]\\|J\\(?:MP\\|SR\\)\\|L\\(?:D[AXY]\\|SR\\)\\|NOP\\|ORA\\|P\\(?:H[AP]\\|L[AP]\\)\\|R\\(?:O[LR]\\|T[IS]\\)\\|S\\(?:BC\\|E[CDI]\\|T[AXY]\\)\\|T\\(?:A[XY]\\|SX\\|X[AS]\\|YA\\)\\)\\>" . font-lock-keyword-face)
   '("\\.\\w+\\>" . font-lock-preprocessor-face))
  "Minimal highlighting for ca65 mode."
  )

(defconst ca65-font-lock-keywords-2
  (append ca65-font-lock-keywords-1
          (list
           '("\\<[XY]\\>" . font-lock-keyword-face) ;; X, Y registers
           '("\\<[A-Z_][A-Z_]*\\>" . font-lock-constant-face)
           '("^[ \t]*@?\\w*:" . font-lock-type-face)
           '("\\<[a-z_]\\w*\\>" . font-lock-variable-name-face)
           ))
  "More highlighting for ca65 mode."
  )
(setq ca65-font-lock-keywords ca65-font-lock-keywords-2)
(defvar ca65-font-lock-keywords ca65-font-lock-keywords-2
  "Default highlight expressions for ca65 mode.")


;; Indent rules:
;; 1. At start of buffer, indent 0
;; 2. at .end*, decrease indent
;; 3. if before we have an .end*, use that line's indent
;; 4. if before we have a .proc, .if*, .scope, .enum, .struct, increase indent
;; 5. labels ignore indent
;; 6. ignore indent otherwise

(defun ca65-indent-line ()
  "Indent current line as ca65 code."
  (interactive)
  (beginning-of-line)
  (if (bobp) ;; rule 1
      (indent-line-to 0)
    (if (looking-at "^[ \t]*@?\\w+:") ;; rule 5
        (indent-line-to 0)
      (let ((not-indented t) cur-indent)
        (if (looking-at "^[ \t]*[.]end") ;; rule 2
            (progn
              (save-excursion
                (forward-line -1)
                (setq cur-indent (- (current-indentation) tab-width)))
              (if (< cur-indent 0)
                  (setq cur-indent 0)))
          (save-excursion
            (while not-indented
              (forward-line -1)
              (if (looking-at "^[ \t]*[.]end") ;; rule 3
                  (progn
                    (setq cur-indent (current-indentation))
                    (setq not-indented nil))
                ;; rule 4
                (if (looking-at "^[ \t]*[.]\\(proc\\>\\|if\\|scope\\>\\|enum\\>\\|struct\\>\\)")
                    (progn
                      (setq cur-indent (+ (current-indentation) tab-width))
                      (setq not-indented nil))
                  (if (bobp) ;; rule 6
                      (setq not-indented nil)))))))
        (if cur-indent
            (indent-line-to cur-indent)
          (indent-line-to 0))))))

(defvar ca65-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?_ "w" st)
    (modify-syntax-entry ?\; "<" st)
    (modify-syntax-entry ?\n ">" st)
    (modify-syntax-entry ?\" "\"" st)
    (modify-syntax-entry ?\' "'" st)
    st)
  "Syntax table for ca65-mode.")

(defun ca65-mode ()
  "Major mode for editing ca65 assembly files."
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table ca65-mode-syntax-table)
  (use-local-map ca65-mode-map)
  (set (make-local-variable 'font-lock-defaults) '(ca65-font-lock-keywords))
  (set (make-local-variable 'indent-line-function) 'ca65-indent-line)
  (setq major-mode 'ca65-mode)
  (setq mode-name "ca65")
  (set-variable 'tab-width 2)
  (run-hooks 'ca65-mode-hook))

(provide 'ca65-mode)
;;; ca65-mode.el ends here
