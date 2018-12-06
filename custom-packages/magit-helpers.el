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

(global-magit-file-mode)

(defun wendel-magit/is-masterish (branch)
  "Tell if BRANCH is masterish (master or production)."
  (or (equal branch "master") (equal branch "production")))

(defun wendel-magit/cleanup-branches ()
  "Delete merged branches."
  (interactive)
  (message "Cleaning up branches...")
  (let ((masterish-branches (seq-filter #'wendel-magit/is-masterish (magit-list-branch-names))))
    (seq-doseq (masterish-branch masterish-branches)
      (message "Checkout %s" masterish-branch)
      (magit-checkout masterish-branch)
      (message "Pull %s" masterish-branch)
      (magit-run-git "pull")
      (message "Remote prune origin %s" masterish-branch)
      (magit-run-git "remote" "prune" "origin")))
  (if (not (equal "master" (magit-get-current-branch)))
      (progn
        (message "Checkout back to master")
        (magit-checkout "master")))
  (magit-refresh)
  (let ((bad-branches (seq-remove #'wendel-magit/is-masterish (magit-list-merged-branches))))
    (if (> (length bad-branches) 0)
        (progn
          (message "Delete merged branch(es) %S" bad-branches)
          (magit-run-git "branch" "-d" bad-branches))))
  (message "Final checkout master")
  (magit-checkout "master")
  (magit-show-refs-popup))

(defun wendel-magit/open-pull-request ()
  "Opens a pull request for current branch on Github."
  (interactive)
  (browse-url
   (format "%s/pull/new/%s"
           (replace-regexp-in-string
            "[.]git$"
            ""
            (magit-get "remote"
                       (magit-get-push-remote)
                       "url"))
           (magit-get-current-branch))))

(magit-define-popup-action 'magit-branch-popup ?z "Cleanup" 'wendel-magit/cleanup-branches)
(magit-define-popup-action 'magit-branch-popup ?P "Pull Request" 'wendel-magit/open-pull-request)
;;; magit-helpers.el ends here
