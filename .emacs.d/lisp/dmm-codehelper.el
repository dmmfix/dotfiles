(defconst dmm-non-preproc-regexp "^\\\([^#]\\|$\\)")
(defconst dmm-preproc-regexp "^#")

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

(defun dmm/rect--default-line-number-format (start end start-at)
  (concat "%"
          (int-to-string (length (int-to-string (+ (count-lines start end)
                                                   start-at))))
          "d"))

(defun dmm/rect-numbers ()
  (interactive)
  (let* ((start (region-beginning))
         (end   (region-end))
         (start-at 0)
         (format (dmm/rect--default-line-number-format start end start-at)))
    (rectangle-number-lines start end start-at format)))

(defun dmm/comment-identifier ()
  (interactive)
  (save-excursion
    (insert "/*")
    (right-word)
    (insert "*/")))

(defun dmm/flush-cc-mode-cache ()
  (interactive)
  (when c-buffer-is-cc-mode
    (c-before-change (point-min) (point-max))
    (c-after-change (point-min) (point-max) (- (point-max) (point-min)))
    (message "invalidated cc-mode cache")))

(provide 'dmm-codehelper)
