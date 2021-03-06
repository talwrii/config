;;; xani-org-mode-arte.el ---
;;

(setq
 org-todo-keywords '((type "TODO(t!)" "NEXT(n!)" "WAIT(w!)" "REOPEN(r!)" "|" "DONE(d!)" "CANCELLED(c@)" "MERGED(m@)"))
 org-directory "~/emacs/org/arte"
 org-agenda-files "~/emacs/org/arte/.agenda"
 ;; org-mobile-files '("~/emacs/org/arte/.agenda") ;; defaults to agenda
 org-mobile-directory "~/Dropbox/Org/mobile.org/arte"
 org-mobile-inbox-for-pull "~/emacs/org/arte/mobile.org"
 org-mobile-agendas (quote default)
 org-combined-agenda-icalendar-file "~/emacs/org/arte.ics"
 org-icalendar-combined-agenda-file "~/emacs/org/arte.ics"
)


(provide 'xani-org-mode-arte)
