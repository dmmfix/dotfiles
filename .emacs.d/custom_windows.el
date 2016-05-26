;; custom settings
(defvar *rocktenn-base-directory* "c:/rocktenn/"
  "Base directory of the Research repository on this machine")

;; By default, go to the research repo
(cd *rocktenn-base-directory*)
(defun dmm/re () (interactive) (cd *rocktenn-base-directory*))
