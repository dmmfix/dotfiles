;; custom settings
(defvar *rocktenn-base-directory* "~/rocktenn"
  "Base directory of the Research repository on this machine")
(defvar *research-base-directory* "~/research-surreal/"
  "Base directory of the Research repository on this machine")

;; By default, go to the research repo

(if (file-exists-p *research-base-directory*)
    (cd *research-base-directory*))
(defun dmm/re () (interactive) (cd *rocktenn-base-directory*))
(defun dmm/su () (interactive) (cd *research-base-directory*))

(setq mac-option-key-is-meta  nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier  'alt)


(global-set-key (kbd "M-h") 'ns-do-hide-emacs)


(setq f "-*-Menlo-normal-normal-normal-*-12-*")
(set-face-attribute 'default nil :font f )
(set-frame-font f nil t)
