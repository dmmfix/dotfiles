(defvar *rocktenn-base-directory* "~/rocktenn/"
  "Base directory of the Research repository on this machine")
(defvar *research-base-directory* "~/research-surreal/"
  "Base directory of the Research repository on this machine")

;; By default, go to the research repo
(cd *research-base-directory*)
(defun dmm/re () (interactive) (cd *rocktenn-base-directory*))
(defun dmm/su () (interactive) (cd *research-base-directory*))
