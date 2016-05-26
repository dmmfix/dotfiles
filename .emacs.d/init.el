;; New year, new .emacs  DMM 2014
;; NB: Much of this thanks to Magnar from EmacsRocks
(if (fboundp 'menu-bar-mode)   (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode)   (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq inhibit-startup-message t)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist         `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Default color scheme is really hard on the eyes.  Fix that first
;; thing
(set-face-background 'default   "grey80")
(set-face-foreground 'default   "black")
(set-face-background 'mode-line "grey65")          ; mode-line too...
(set-face-foreground 'mode-line "black")
(set-face-background 'mode-line-inactive "grey60")
(set-face-foreground 'mode-line-inactive "black")


;; Set up load path
(setq site-lisp-dir (expand-file-name "site-lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path site-lisp-dir)

(require 'setup-package)   ; Setup and install default packages

;; Determine osx/win/linux and set specific key bindings to regularize
;; the interface, plus window appearance
(require 'dmm-platform)   ; Setup dmm/platform-is-mac?, etc
(require 'dmm-defaults)   ; Fix emacs boneheadedness (better-defaults.el based)
(require 'dmm-appearance) ; Setup colors, general window appearance

;; Local settings for used packages
(require 'setup-smex)      ; smart M-x
(require 'setup-flycheck)  ; on-the-fly syntax check
(require 'setup-yasnippet) ; snippets
(require 'setup-dired)
(require 'setup-p4)
(require 'setup-cc-mode)

;; =============================================================================
;; Tiny stuff
;; =============================================================================
(global-auto-revert-mode t)

;;(setq-default rtags-path "/usr/local/bin")
;;(require 'rtags)
;;(rtags-enable-standard-keybindings)

(require 'volatile-highlights)
(volatile-highlights-mode t)

(setq-default ffap-url-regexp nil)
(require 'ffap)
(ffap-bindings)

(require 'expand-region)
(global-set-key (kbd "M-r") 'er/expand-region)


;; Ace jump,
(require 'ace-jump-mode)
(require 'ace-jump-buffer)
(global-set-key (kbd "M-m") 'ace-jump-mode)
(global-set-key (kbd "M-n") 'ace-jump-buffer)
(global-set-key (kbd "M-i") 'back-to-indentation)

;; Desktop save/restore and emacs reset
(global-set-key (kbd "C-S-M-<backspace>") 'desktop-clear)
(global-set-key (kbd "C-M-_")             'desktop-save-in-desktop-dir)
(global-set-key (kbd "C-M-+")             'desktop-revert)

(global-set-key (kbd "C-c h") (lambda () (interactive) (ff-find-other-file nil t)))


; Rectangle numbers for array fills, etc.
(defun dmm/rect--default-line-number-format (start end start-at)
  (concat "%"
          (int-to-string (length (int-to-string (+ (count-lines start end)
                                                   start-at))))
          "d"))
(global-set-key (kbd "C-c #")
                (lambda () (interactive)
                  (let* ((start (region-beginning))
                         (end   (region-end))
                         (start-at 0)
                         (format (dmm/rect--default-line-number-format start end start-at)))
                    (rectangle-number-lines start end start-at format))))



;; Expand region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; Emacs server
(setq-default server-use-tcp t)
(require 'server)
(unless (server-running-p) (server-start))

;; Local settings and stuffs
(require 'codehelper)

;; Company mode settings
(require 'company)
(add-to-list 'company-backends 'company-c-headers)

;; =============================================================================
;; =============================================================================
;; =============================================================================
;; Things to look into
;; =============================================================================
                                        ; cpputils-cmake
                                        ; find-file- at-point/in-project
                                        ; diminish
                                        ; mode line darker than background for splits
                                        ; figure out magit
                                        ; webjump
                                        ; flyspell?
                                        ; f (package)
                                        ; disaster
                                        ; desktop-registry
                                        ; smartparens
                                        ; projectile
                                        ; eshell
                                        ; gist
                                        ; uniqify

(setq *setenv-command* "\"C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\vcvarsall.bat\" amd64")

(defun make-ocre-subdirectory (subdir)
  "Makes a subdirectory of the Research root for this machine"
  (concat *rocktenn-base-directory* subdir))

;;;FIX!
(setq-default compile-command (concat *setenv-command* " && msbuild"))
(global-set-key (kbd "<f5>")
                (lambda () (interactive)
                  (let ((compilation-read-command t))
                    (save-some-buffers t)
                    (compile compile-command))))

(defmacro make-ocre-compile (fn-name dir &optional command)
  (let ((cmd (or command compile-command)))
    `(defun ,fn-name (&optional arg)
       (interactive)
       (save-some-buffers t nil)
       (compile (concat ,*setenv-command* " && "
                        "cd " ,dir
                        " && " ,cmd " "
                        (or arg ""))))))

;; Reapply for analysis and release mode...
(defmacro bind-ocre-compile (key command)
  `(let ()
     (global-set-key (kbd ,key) (lambda () (interactive) (,command)))
     (global-set-key (kbd ,(concat "S-" key)) (lambda () (interactive) (,command "-a")))
     (global-set-key (kbd ,(concat "M-" key)) (lambda () (interactive) (,command "-q")))
     (global-set-key (kbd ,(concat "M-S-" key)) (lambda () (interactive) (,command "-a -q")))
     (global-set-key (kbd ,(concat "C-" key)) (lambda () (interactive) (,command "-r")))
     (global-set-key (kbd ,(concat "M-C-" key)) (lambda () (interactive) (,command "-r -q")))
     (global-set-key (kbd ,(concat "C-S-" key)) (lambda () (interactive) (,command "-a -r")))
     (global-set-key (kbd ,(concat "M-C-S-" key)) (lambda () (interactive) (,command "-a -r -q")))))

(make-ocre-compile ocre-compile-all (make-ocre-subdirectory "build") "msbuild /verbosity:n OculusResearch.sln /t:Build /p:Configuration=Debug /p:Platform=x64")
(make-ocre-compile ocre-clean-all   (make-ocre-subdirectory "build") "msbuild /verbosity:m OculusResearch.sln /t:Clean /p:Configuration=Debug|x64")

;; Work bindings...
(make-ocre-compile ocre-compile-audio (make-ocre-subdirectory "projects/audio/hrtf_driver") "msbuild /verbosity:n hrtf_driver.sln /t:Build /p:Configuration=Release /p:Platform=x64")

;; Fix stupid C-up/down behavior
(global-set-key   (kbd "C-<down>")  (lambda () (interactive) (forward-line 7)))
(global-set-key   (kbd "C-<up>")    (lambda () (interactive) (forward-line -7)))

;; Better error movement
(global-set-key   (kbd "M-`") 'first-error)
(global-set-key   (kbd "M-1") 'previous-error)
(global-set-key   (kbd "M-2") 'next-error)

(setq-default whitespace-style '(face tabs trailing space-before-tab))
(setq-default buffer-file-coding-system 'utf-8-unix)

(defun ocre/txt ()
  (interactive)
  (if (and (not buffer-read-only)
           (not (or (eql buffer-file-coding-system 'utf-8-unix)
                    (eql buffer-file-coding-system 'prefer-utf-8-unix)
                    (eql buffer-file-coding-system 'undecided-unix))))
      (progn (print buffer-file-coding-system)
             (set-buffer-file-coding-system 'utf-8-unix)))
  (whitespace-mode nil)
  )

(global-set-key (kbd "<f7>") 'ocre/txt)
(add-hook 'c++-mode-hook     'ocre/txt)
(add-hook 'c-mode-hook       'ocre/txt)
(add-hook 'lua-mode-hook     'ocre/txt)
(add-hook 'nxml-mode-hook    'ocre/txt)

;;;; Test new c++11x keywords
;;(add-hook
;; 'c++-mode-hook
;; '(lambda()
;;    ;; We could place some regexes into `c-mode-common-hook', but note that their evaluation order
;;    ;; matters.
;;    (font-lock-add-keywords
;;     nil '(;; complete some fundamental keywords
;;           ("\\<\\(void\\|unsigned\\|signed\\|char\\|short\\|bool\\|int\\|long\\|float\\|double\\)\\>" . font-lock-keyword-face)
;;           ;; namespace names and tags - these are rendered as constants by cc-mode
;;           ("\\<\\(\\w+::\\)" . font-lock-function-name-face)
;;           ;;  new C++11 keywords
;;           ("\\<\\(alignof\\|alignas\\|constexpr\\|decltype\\|noexcept\\|nullptr\\|static_assert\\|thread_local\\|override\\|final\\)\\>" . font-lock-keyword-face)
;;           ("\\<\\(char16_t\\|char32_t\\)\\>" . font-lock-keyword-face)
;;           ;; PREPROCESSOR_CONSTANT, PREPROCESSORCONSTANT
;;           ("\\<[A-Z]*_[A-Z_]+\\>" . font-lock-constant-face)
;;           ("\\<[A-Z]\\{3,\\}\\>"  . font-lock-constant-face)
;;           ;; hexadecimal numbers
;;           ("\\<0[xX][0-9A-Fa-f]+\\>" . font-lock-constant-face)
;;           ;; integer/float/scientific numbers
;;           ("\\<[-+]?[0-9]*\\.?[0-9]+\\([uUlL]+\\|[eE][-+]?[0-9]+\\)?[fFlL]?\\>" . font-lock-constant-face)
;;           ;; c++11 string literals
;;           ;;       L"wide string"
;;           ;;       L"wide string with UNICODE codepoint: \u2018"
;;           ;;       u8"UTF-8 string", u"UTF-16 string", U"UTF-32 string"
;;           ("\\<\\([LuU8]+\\)\".*?\"" 1 font-lock-keyword-face)
;;           ;;       R"(user-defined literal)"
;;           ;;       R"( a "quot'd" string )"
;;           ;;       R"delimiter(The String Data" )delimiter"
;;           ;;       R"delimiter((a-z))delimiter" is equivalent to "(a-z)"
;;           ("\\(\\<[uU8]*R\"[^\\s-\\\\()]\\{0,16\\}(\\)" 1 font-lock-keyword-face t) ; start delimiter
;;           (   "\\<[uU8]*R\"[^\\s-\\\\()]\\{0,16\\}(\\(.*?\\))[^\\s-\\\\()]\\{0,16\\}\"" 1 font-lock-string-face t)  ; actual string
;;           (   "\\<[uU8]*R\"[^\\s-\\\\()]\\{0,16\\}(.*?\\()[^\\s-\\\\()]\\{0,16\\}\"\\)" 1 font-lock-keyword-face t) ; end delimiter
;;
;;           ;; user-defined types (rather project-specific)
;;           ("\\<[A-Za-z_]+[A-Za-z_0-9]*_\\(type\\|ptr\\)\\>" . font-lock-type-face)
;;           ("\\<\\(xstring\\|xchar\\)\\>" . font-lock-type-face)
;;           ))
;;    ) t)

;; Where has this been all my life?
(global-set-key (kbd "C-x C-<up>") 'windmove-up)
(global-set-key (kbd "C-x C-<down>") 'windmove-down)
(global-set-key (kbd "C-x C-<right>") 'windmove-right)
(global-set-key (kbd "C-x C-<left>") 'windmove-left)

(defun flush-cc-mode-cache ()
  (interactive)
  (when c-buffer-is-cc-mode
    (c-before-change (point-min) (point-max))
    (c-after-change (point-min) (point-max) (- (point-max) (point-min)))
    (message "invalidated cc-mode cache")))


(defun inv-quat (a)
  (list (first a)
        (- (second a))
        (- (third a))
        (- (fourth a))))

(defun quat-to-angaxis (a)
  (let* ((w (first a))
         (x (second a))
         (y (third a))
         (z (fourth a))
         (norm (sqrt (+ (* x x) (* y y) (* z z)))))
    (list (* (acos w) 2)
          (list (/ x norm)
                (/ y norm)
                (/ z norm)))))

(defun mul-quat (a b)
  (let ((a1 (first a))
        (b1 (second a))
        (c1 (third a))
        (d1 (fourth a))
        (a2 (first b))
        (b2 (second b))
        (c2 (third b))
        (d2 (fourth b)))
    (list (+ (* a1 a2 )
              (- (* b1 b2))
              (- (* c1 c2))
              (- (* d1 d2)))     ; w
           (+ (* a1 b2)
              (* b1 a2)
              (* c1 d2)
              (- (* d1 c2))) ; x
           (+ (* a1 c2)
              (- (* b1 d2))
              (* c1 a2)
              (* d1 b2))     ; y
           (+ (* a1 d2)
              (* b1 c2)
              (- (* c1 b2))
              (* d1 a2))     ; z
           )))
           
(defun cross-prod (va vb)
  (let ((ax (first va))
        (ay (second va))
        (az (third va))
        (bx (first vb))
        (by (second vb))
        (bz (third vb)))
    (list (- (* ay bz) (* az by))
          (- (* az bx) (* ax bz))
          (- (* ax by) (* ay bx)))))

(defun dot-prod (va vb)
  (let ((ax (first va))
        (ay (second va))
        (az (third va))
        (bx (first vb))
        (by (second vb))
        (bz (third vb)))
    (+ (* ax bx)
       (* ay by)
       (* az bz))))

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
