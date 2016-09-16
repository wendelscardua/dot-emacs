;;; minesweeper-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "minesweeper" "minesweeper.el" (22473 55390
;;;;;;  76691 705000))
;;; Generated autoloads from minesweeper.el

(autoload 'minesweeper "minesweeper" "\
Major mode for playing Minesweeper in Emacs.

There's a field of squares; each square may hold a mine.
Your goal is to uncover all the squares that don't have mines.
If a revealed square doesn't have a mine, you'll see how many mines
are in the eight neighboring squares.
You may mark squares, which protects them from accidentally being revealed.

\\{minesweeper-mode-map}

\(fn)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; minesweeper-autoloads.el ends here
