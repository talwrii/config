;;; cfg-orgmode.el ---
;; common includes and configuration

;; auto GPG
(epa-file-enable)

;; expand comment to next line if previous line was a comment
;; (global-set-key (kbd "RET") 'comment-indent-new-line)

;; fix yes no questions
(fset 'yes-or-no-p 'y-or-n-p)

;; moving between frames


(global-set-key [s-left] 'windmove-left)          ; move to left windnow
(global-set-key [s-right] 'windmove-right)        ; move to right window
(global-set-key [s-up] 'windmove-up)              ; move to upper window
(global-set-key [s-down] 'windmove-down)          ; move to downer window

;; use ibuffer by default
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

;; remove trailing whitespace xcept on some "special" paths
(defun auto-whitespace-remove ()
  ;; haproxy needs spaces in some edge cases
  (if (string-match "haproxy" buffer-file-name) nil (delete-trailing-whitespace))
)
(add-hook 'before-save-hook 'auto-whitespace-remove)

;; I edit configs a lot so if it's unknown file it's probably a config
(setq-default major-mode 'conf-mode)
;; I always use server mode here do replace default kill with server-edit
(global-set-key [(control x) (k)] '(lambda ()
  (interactive)
  (if server-buffer-clients
      (server-edit)
    (when (and (frame-live-p (selected-frame))
               (kill-this-buffer))
      )
    (kill-this-buffer)
    )
  )
)
;; workaround for menu-bar-non-minibuffer-window-p: Wrong type argument: frame-live-p
(setq menu-updating-frame nil)



(global-linum-mode 1)  ;; show line numbers in marigin, need newer emacs than centos 5 one
(global-hl-line-mode 1) ;; highlight current line - looks ugly on emacs21 coz no 256 color support on centos

;; highlight while expression in parens
(setq
 show-paren-style 'expression
 show-paren-delay 0.001
)


;; default printing program:
(setq lpr-command "gtklp")

;; display time in modeline
;; (setq
;;  display-time-day-and-date t
;;  display-time-24hr-format t)
;; (display-time)

(show-paren-mode) ;; show matching ()
(column-number-mode 1) ;; and column at bot
(setq-default fill-column 120)

(defconst emacs-autosave-dir (format "%s/%s/%s/" "~" "emacs" "autosave"))

(setq
  backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/emacs/backup"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 4
 kept-old-versions 0
 auto-save-file-name-transforms `((".*" ,emacs-autosave-dir t))
 auto-save-list-file-prefix emacs-autosave-dir
 tab-width 4
 color-theme-is-global t
 version-control t       ; use versioned backups]
 yaml-block-literal-search-lines 1000
 yaml-indent-offset 4
 kill-read-only-ok t  ; allow yanking read-only lines
 make-pointer-invisible nil ; dont hide pointer
 )

(custom-set-variables
 '(indent-tabs-mode nil)
 '(standard-indent 4)
 '(tab-width 4)
 '(case-fold-search t)
 '(current-language-anvironment "UTF-8")
 '(display-time-mail-file (quote none))
 '(display-time-use-mail-icon t)
 '(file-cache-completion-ignore-case t)
 '(global-font-lock-mode t nil (font-lock))
 '(gnuserv-program (concat exec-directory "/gnuserv"))
 '(inhibit-startup-screen t)
 '(ibuffer-default-sorting-mode (quote major-mode))
 '(ibuffer-default-sorting-reversep t)
 '(load-home-init-file t t)
 '(mouse-yank-at-point 1)
 '(save-abbrevs (quote silently))
 ;; magick needed to make jabber-mode work with gmail and arte jabber servers
 ;;'(starttls-extra-arguments (quote ("--insecure")))
 ;; for wanderlust
 '(ssl-certificate-verification-policy 0)
 '(ssl-program-arguments (quote ("--insecure" "-p" service host)))
 '(ssl-program-name "gnutls-cli")
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))
 '(uniquify-min-dir-content 2)
 '(whitespace-line-column 200)
 '(whitespace-style (quote (face tabs trailing lines tab-mark)))
)
;; Show tabs with the same color as trailing whitespace
;; (add-hook 'font-lock-mode-hook
;;   (lambda ()
;;     (font-lock-add-keywords
;;       nil
;;       '(("\t" 0 'trailing-whitespace prepend)))))

(global-whitespace-mode)

;; do not ask for kill confirmation on flymake process
(defadvice flymake-start-syntax-check-process (after
                                               cheeso-advice-flymake-start-syntax-check-1
                                               (cmd args dir)
                                               activate compile)
  ;; set flag to allow exit without query on any

  (set-process-query-on-exit-flag ad-return-value nil))

;; colors
(global-rainbow-delimiters-mode)
(rainbow-mode)

;; minibuffer depth
(minibuffer-depth-indicate-mode 99)

;; do not ask to reload TAGS
(setq tags-revert-without-query 1)

;; do not kill scratch
(protect-buffer-from-kill-mode nil (get-buffer "*scratch*"))

;; use emacs buffers, so we dont get read only crap from clipboard
;;(global-set-key [mouse-2] 'mouse-yank-at-click)

;; mouse+ show position when holding paste
(global-set-key [down-mouse-2]  'mouse-flash-position-or-M-x)

;; revert files if they changed on disk (git)
(global-auto-revert-mode)

(provide 'xani-common)
