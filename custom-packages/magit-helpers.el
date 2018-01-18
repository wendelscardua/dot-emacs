;;; magit-helpers.el --- Helpers for Magit

;; Copyright (C) 2018 Wendel Scardua
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

;; The functions here defined are shortcuts for common git activities
;; (at least for me)

;; Installation
;; ============

;; Place this file in your load path; then, place the following
;; command somewhere in your initialization file:

;; (require 'magit-helpers)

;;; Code:
(require 'magit)

(defun wendel-magit/is-masterish (branch)
  "Tell if BRANCH is masterish (master or production)."
  (or (equal branch "master") (equal branch "production")))

(defun wendel-magit/cleanup-branches ()
  "Delete merged branches."
  (interactive)
  (let ((masterish-branches (seq-filter #'wendel-magit/is-masterish (magit-list-branch-names))))
    (seq-doseq (masterish-branch masterish-branches)
      (magit-checkout masterish-branch)
      (magit-run-git "pull")
      (magit-run-git "remote" "prune" "origin"))
    (let ((bad-branches (seq-remove #'wendel-magit/is-masterish (magit-list-merged-branches))))
      (if (> (length bad-branches) 1)
          (magit-run-git "branch" "-d" bad-branches))))
  (magit-checkout "master")
  (magit-show-refs-popup))

(magit-define-popup-action 'magit-branch-popup ?z "Cleanup" 'wendel-magit/cleanup-branches)
;;; magit-helpers.el ends here
