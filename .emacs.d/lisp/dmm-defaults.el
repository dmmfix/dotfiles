;;; dmm-defaults.el --- My personal opinions, strongly flavored by better-defaults.el

(setq initial-scratch-message "")
(when (not dmm/is-mac?)
  (setq visible-bell t))

(setq-default user-mail-address "symlink.sk@gmail.com")
(setq-default user-full-name    "Dave Moore")

(delete-selection-mode t)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(require 'saveplace)
(setq-default save-place-file "~/.places")
(setq-default save-place t)
(setq-default split-width-threshold 200)

(column-number-mode t)

(setq-default default-tab-width 4)
(setq-default indent-tabs-mode nil)
(let ((list nil))
  (setq tab-stop-list (dotimes (x 20 (nreverse list))
                        (push (* (+ x 1) default-tab-width) list))))

; (global-set-key (kbd "M-/") 'hippie-expand)

(global-set-key (kbd "C-M-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-M-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-s")   'isearch-forward)
(global-set-key (kbd "C-r")   'isearch-backward)

(global-set-key (kbd "M-g") 'goto-line)

(show-paren-mode 1)
(setq-default indent-tabs-mode nil)
(setq x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      desktop-dirname user-emacs-directory
      backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))

(provide 'dmm-defaults)
