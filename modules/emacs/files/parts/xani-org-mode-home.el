;;; xani-org-mode-home.el ---
;;

(setq
  org-todo-keywords '((type "TODO(t!)" "NEXT(n!)" "WAIT(w!)" "|" "DONE(d!)" "CANCELLED(c@)"))
  org-directory "~/emacs/org/share"
  org-agenda-files "~/emacs/org/share/.agenda"
;;  org-mobile-files '("~/emacs/org/share/.agenda") ;; defaults to agenda
  org-mobile-directory "~/Dropbox/Org/mobile.org/share"
  org-mobile-inbox-for-pull "~/emacs/org/share/mobile.org"
  org-combined-agenda-icalendar-file "~/emacs/org/share.ics"
  org-icalendar-combined-agenda-file "~/emacs/org/share.ics"

)

(provide 'xani-org-mode-home)
