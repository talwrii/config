;;; xani-testing.el ---
;;

;; random shit in testing
(global-set-key "\M-`" 'hippie-expand)


;; test clipboard fix
(setq
 x-select-enable-clipboard t
 x-select-request-type (quote UTF8_STRING)
 yank-pop-change-selection t
)



(defalias 'server-kill-buffer-query-function '(lambda () t))

;; or
;; (remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)*
;; somewhere after emacs server loaded

(provide 'xani-testing)
