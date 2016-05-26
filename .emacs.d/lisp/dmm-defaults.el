;;; dmm-defaults.el --- My personal opinions, strongly flavored by better-defaults.el

(setq initial-scratch-message "")
(when (not dmm/is-mac?)
  (setq visible-bell t))
(when dmm/is-mac?
  (setq visible-bell nil)
  (setq ring-bell-function 'ignore))

; Lazy...
(fset 'yes-or-no-p 'y-or-n-p)

(setq-default user-mail-address "symlink.sk@gmail.com")
(setq-default user-full-name    "Dave Moore")

(delete-selection-mode t)

; Making Buffer Names Unique
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

; Store your place in each file visited
(require 'saveplace)
(setq-default save-place-file "~/.places")
(setq-default save-place t)

; Why the hell wouldn't you have this?
(column-number-mode t)

; Tabs are 4 spaces but don't use them
(setq-default default-tab-width 4)
(setq-default indent-tabs-mode nil)

(show-paren-mode 1)

(setq x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      desktop-dirname user-emacs-directory
      backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))

(provide 'dmm-defaults)
