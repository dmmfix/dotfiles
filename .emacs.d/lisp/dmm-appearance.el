;; Highlight matching paren
(show-paren-mode   1)
(fringe-mode       '(1 . 0))
(tooltip-mode      -1)
(blink-cursor-mode -1)
(setq frame-title-format '(buffer-file-name "%f" ("%b")))

;; Hate wrapping lines, messes up column selection
(setq-default truncate-lines t)

(defvar dmm--res-to-frame-alist
  '(((1280 800)  . ((181 57)  (0 0)))  ; mb air
    ((1440 900)  . ((150 55)  (80  60)))  ; mb air
    ((1920 1080) . ((150 60)  (80  60)))  ; 1080p display
    ((1920 1200) . ((150 71)  (75  60)))
    ((1680 1050) . ((150 60)  (80  60)))
    ((2560 1600) . ((160 88)  (480 60)))
    ((5120 1826) . ((160 88)  (480 60)))
    ((3760 2306) . ((160 88)  (80  60)))
    ((3840 2160) . ((160 100) (700 200)))))

(defun dmm--get-position ()
  (let* ((x (display-pixel-width))
         (y (display-pixel-height))
         (prop (assoc-if (lambda (elem) (equal (list x y) elem)) dmm--res-to-frame-alist)))
    (if prop
        (caddr prop)
      '(60 60))))

(defun dmm--get-dimension ()
  (let* ((x (display-pixel-width))
         (y (display-pixel-height))
         (prop (assoc-if (lambda (elem) (equal (list x y) elem)) dmm--res-to-frame-alist)))
    (if prop
        (cadr prop)
      '(160 88))))

(defun dmm-frame-specs ()
  (interactive)
  (let ((pos (dmm--get-position))
        (dim (dmm--get-dimension)))
    (set-frame-position (selected-frame) (first  pos) (second pos))
    (set-frame-size (selected-frame) (first  dim) (second dim))))
(dmm-frame-specs)

(defvar *default-position* (dmm--get-position)
  "Supportable size of the window, givn the font choice")

(defvar *default-dimensions* (dmm--get-dimension)
  "Supportable size of the window, givn the font choice")

(provide 'dmm-appearance)
