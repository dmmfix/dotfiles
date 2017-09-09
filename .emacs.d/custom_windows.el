;; custom settings
(defvar *rocktenn-base-directory* "c:/rocktenn/"
  "Base directory of the Research repository on this machine")
(defvar *surreal-base-directory* "c:/research-surreal/"
  "Base directory of the Research repository on this machine")

;; By default, go to the surreal repo
(cd *surreal-base-directory*)
(defun dmm/re () (interactive) (cd *rocktenn-base-directory*))
(defun dmm/su () (interactive) (cd *surreal-base-directory*))
