;; <%= @puppet_header %>
;; <%=  __FILE__.gsub(/.*?puppet\//,@fqdn + ':') %>
(require 'bbdb-wl)
(bbdb-wl-setup)
(require 'mime-bbdb)
(autoload 'bbdb         "bbdb-com" "Insidious Big Brother Database" t)
(autoload 'bbdb-name    "bbdb-com" "Insidious Big Brother Database" t)
(autoload 'bbdb-company "bbdb-com" "Insidious Big Brother Database" t)
(autoload 'bbdb-net     "bbdb-com" "Insidious Big Brother Database" t)
   (add-hook 'wl-mail-setup-hook 'bbdb-insinuate-sendmail)

   (setq bbdb-use-alternate-names t)

   (setq bbdb-file "~/.bbdb")
   (setq bbdb/mail-auto-create-p   'bbdb-ignore-some-messages-hook)
   (put 'ML 'field-separator "\n")
   (put 'User-Agent 'field-separator "\n")

   (setq bbdb-auto-notes-alist
   '(
   ("X-ML-Name" (".*$" ML 0))
   ("X-Mailinglist" (".*$" ML 0))
   ("X-Ml-Name" (".*$" ML 0))
   ("X-Mailer" (".*$" User-Agent 0))
   ("X-Newsreader" (".*$" User-Agent 0))
   ("User-Agent" (".*$" User-Agent 0))
   ("X-Face" ("[ \t\n]*\\([^ \t\n]*\\)\\([ \t\n]+\\([^ \t\n]+\\)\\)?\\([ \t\n]+\\([^ \t\n]+\\)\\)?\\([ \t\n]+\\([^ \t\n]+\\)\\)?"
   face "\\1\\3\\5\\7"))
   ))

   ;;auto-fill
   (setq mime-edit-mode-hook
   '(lambda ()
   (auto-fill-mode 1)))

   ;;(setq wl-message-visible-field-list '("^To" "^Subject" "^From" "^Date" "^Cc"))
   ;;(setq wl-message-ignored-field-list '("^"))

   ;;; popup display of record in the .bbdb
   (setq bbdb-use-pop-up t)
   (setq signature-use-bbdb t)

   ;;; automatic adding to ML field
   (add-hook 'bbdb-notice-hook 'bbdb-auto-notes-hook)

   ;; wanderlust
   (autoload 'wl "wl" "Wanderlust" t)
   (autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
   (autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)


   ;; IMAP
   <% if @mail_imap_server %>(setq elmo-imap4-default-server "<%= @mail_imap_server %>")<% end %>
   <% if @mail_user %>(setq elmo-imap4-default-user "<%= @mail_user %>")<% end %>
   (setq elmo-imap4-default-authenticate-type 'plain)
   (setq elmo-imap4-default-port '993)
   (setq elmo-imap4-default-stream-type 'ssl)

;;(setq elmo-imap4-use-modified-utf7 t)

;; SMTP
(setq wl-from "<%= @mail_from %>")

(setq wl-organization "Artegence")
(setq wl-user-mail-address-list (quote (<% Array(@mail_address_list).each do |email| %>"<%= email %>" <% end %> )))
(setq wl-smtp-connection-type 'starttls)
(setq wl-smtp-posting-port 587)
(setq wl-smtp-authenticate-type "plain")
(setq wl-smtp-posting-user "<%= @mail_smtp_user %>")
<% if @mail_smtp_server %>(setq wl-smtp-posting-server "<%= @mail_smtp_server %>")<% end %>
<% if @mail_domain %>(setq wl-local-domain "<%= @mail_domain %>")<% end %>
(setq wl-default-folder "%INBOX")
(setq wl-default-spec "%")
(setq wl-draft-folder "%INBOX.Drafts") ; Gmail IMAP
(setq wl-trash-folder "%INBOX.Trash")

(setq wl-folder-check-async t)
;; let gmail do it
;;   (setq wl-insert-message-id nil)
;;(setq wl-message-id-domain "devrandom.pl")

;;(setq elmo-imap4-use-modified-utf7 t)

(autoload 'wl-user-agent-compose "wl-draft" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))