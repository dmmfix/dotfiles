(defun dmm--set-programming-fonts (boring)
  (set-face-foreground 'font-lock-comment-face  "darkblue")
  (set-face-foreground 'font-lock-constant-face "darkgreen")
  (set-face-foreground 'font-lock-string-face   "darkgreen")
  (if boring
      (progn 
             (set-face-foreground 'font-lock-function-name-face "black")
             (set-face-foreground 'font-lock-keyword-face       "black")
             (set-face-foreground 'font-lock-preprocessor-face  "black")
             (set-face-foreground 'font-lock-type-face          "black")
             (set-face-foreground 'font-lock-variable-name-face "black"))
    (progn (set-face-foreground 'font-lock-string-face        "darkgreen")
           (set-face-foreground 'font-lock-function-name-face "darkred")
           (set-face-foreground 'font-lock-keyword-face       "darkred")
           (set-face-foreground 'font-lock-preprocessor-face  "darkred")
           (set-face-foreground 'font-lock-type-face          "#4040FF")
           (set-face-foreground 'font-lock-variable-name-face "#4040FF"))))

(defun dmm--programming-mode-tweak ()
  "Font Lock On, Indent on newline"
  (dmm--set-programming-fonts t)
  (local-set-key (kbd "RET") 'newline-and-indent))

(defun dmm--c-mode-tweak ()
  "Normal programming tweaks, plus set dmoore style"
  (dmm--programming-mode-tweak)
  (set-fill-column 80)
  (whitespace-mode t)
  (c-set-style "granny"))

(add-hook 'c-mode-common-hook   'dmm--c-mode-tweak)

;;
;; C++ indentation style
;;
(defconst granny-c-style
  '((c-electric-pound-behavior   . nil)
    (c-tab-always-indent         . t)
    (c-block-comment-prefix      . nil)
    (c-backslash-max-column      . 80)
    (c-comment-only-line-offset  . 0)
    (c-hanging-braces-alist      . ((class-open)
                                    (class-close)
                                    (defun-open)
                                    (defun-close)
                                    (inline-open)
                                    (inline-close)
                                    (brace-list-open)
                                    (brace-list-close)
                                    (brace-list-intro)
                                    (brace-list-entry)
                                    (block-open)
                                    (block-close)
                                    (substatement-open)
                                    (statement-case-open)
                                    (class-open)))
    (c-hanging-colons-alist      . ((inher-intro)
                                    (case-label)
                                    (label)
                                    (access-label)
                                    (access-key)
                                    (member-init-intro)))
    (c-cleanup-list              . (scope-operator
                                    list-close-comma
                                    defun-close-semi))
    (c-offsets-alist             . ((arglist-close         . c-lineup-arglist)
                                    (innamespace . -)
                                    (label                 . -4)
                                    (access-label          . -4)
                                    (substatement-open     .  0)
                                    (innamespace           .  0)
                                    (statement-case-intro  .  4)
                                    (case-label            .  4)
                                    (member-init-intro     .  2)
                                    (block-open            .  0)
                                    (inline-open           .  0)
                                    (topmost-intro-cont    .  0)
                                    (knr-argdecl-intro     . -4)))
    (c-echo-syntactic-information-p . t))
  "Granny C++ Style")
(c-add-style "granny" granny-c-style)

(provide 'setup-cc-mode)

