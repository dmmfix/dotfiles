(require 'cl)

(setq dmm/is-win?   nil)
(setq dmm/is-linux? nil)
(setq dmm/is-mac?   nil)

(ecase system-type
  (windows-nt (setq dmm/is-win?   t))
  (gnu/linux  (setq dmm/is-linux? t))
  (darwin     (setq dmm/is-mac?   t)))

;; ================
;; Windows Settings
(when dmm/is-win?
  (setq dmm/custom-file (expand-file-name "custom_windows.el"
                                          user-emacs-directory)))

;; ================
;; Linux Settings
(when dmm/is-linux?
  (setq dmm/custom-file (expand-file-name "custom_linux.el"
                                          user-emacs-directory)))

;; =============
;; OS X Settings
(when dmm/is-mac?
  (setq dired-use-ls-dired nil)
  (setq dmm/custom-file (expand-file-name "custom_osx.el"
                                          user-emacs-directory)))

;; Create the custom file if it doesn't exist, then load it
(unless (file-exists-p dmm/custom-file)
  (write-region ";; custom settings" 0 dmm/custom-file))
(load dmm/custom-file)

(provide 'dmm-platform)
