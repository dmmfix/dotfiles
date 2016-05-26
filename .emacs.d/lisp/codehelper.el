(defconst dmm-non-preproc-regexp "^\\\([^#]\\|$\\)")
(defconst dmm-preproc-regexp "^#")

(defun dmm/sort-includes ()
  "Sort all include directives contiguous with the current point"
  (interactive)
  (save-excursion
    (let* ((pos (point))
           (beginning (1+ (re-search-backward dmm-non-preproc-regexp))))
      (forward-line)
      (re-search-forward dmm-non-preproc-regexp)
      (forward-line -1)
      (sort-lines nil beginning (point)))))

(defun dmm/jump-to-includes ()
  "Jumps to include portion of the file (or top, if none), saving current position to reg I"
  (interactive)
  (point-to-register ?i t)
  (beginning-of-buffer)
  (re-search-forward dmm-preproc-regexp)
  (beginning-of-line))

(defun dmm/jump-back ()
  "Restores state after dmm-jump-to-includes"
  (interactive)
  (register-to-point ?i))

;; Clear tabs from the file.
(defun dmm/clear-tabs ()
  "Clear tabs from file"
  (interactive)
  (save-excursion
    (untabify (point-min) (point-max))))

(defun dmm/fix-whitespace ()
  "Tabs, trailers, gone!"
  (interactive)
  (dmm/clear-tabs)
  (delete-trailing-whitespace))

(defun dmm/header-forfile (filename)
  "turns file.(cpp|c) into file.h"
  (portable-replace-in-string (file-name-nondirectory filename) "\\(cpp\\|c\\)$" "h"))

(provide 'codehelper)
