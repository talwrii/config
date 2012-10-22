;;; cfg-orgmode.el ---
;; common includes and configuration

;; auto GPG
(epa-file-enable)


(global-set-key (kbd "RET") 'comment-indent-new-line)

;; fix yes no questions
(fset 'yes-or-no-p 'y-or-n-p)


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
(global-set-key [(control x) (k)] 'kill-this-buffer) ;; kill buffer without questions

(global-linum-mode 1)  ;; show line numbers in marigin, need newer emacs than centos 5 one
(global-hl-line-mode 1) ;; highlight current line - looks ugly on emacs21 coz no 256 color support on centos

;; default printing program:
(setq lpr-command "gtklp")


(setq
 display-time-day-and-date t
 display-time-24hr-format t)
(display-time)

(show-paren-mode) ;; show matching ()
(column-number-mode 1) ;; and column at bot
(setq-default fill-column 120)

(setq
  backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saved"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 4
 kept-old-versions 0
 tab-width 4
 indent-tabs-mode nil
 color-theme-is-global t
 version-control t)       ; use versioned backups

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(enable-recursive-minibuffers t)
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
 '(setq-default indent-tabs-mode)
 '(standard-indent 4)
 '(tab-width 4)
 ;; magick needed to make jabber-mode work with gmail and arte jabber servers
 '(starttls-extra-arguments (quote ("--insecure")))
;; for wanderlust
 '(ssl-certificate-verification-policy 0)
 '(ssl-program-arguments (quote ("--insecure" "-p" service host)))
 '(ssl-program-name "gnutls-cli")
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))
 '(uniquify-min-dir-content 2)
 '(whitespace-line-column 200)
)


(provide 'xani-common)