;;; xani-tabbar.el ---
;;
;;(tabbar-mode)
;;(dolist (func '(tabbar-mode tabbar-forward-tab tabbar-forward-group tabbar-backward-tab tabbar-backward-group))
 ;;  (autoload func "tabbar" "Tabs at the top of buffers and easy control-tab navigation")
;;)


(setq
 tabbar-ruler-global-tabbar t ; If you want tabbar
 tabbar-ruler-global-ruler nil ; if you want a global ruler
 tabbar-ruler-popup-menu nil ; If you want a popup menu.
 tabbar-ruler-popup-toolbar nil ; If you want a popup toolbar
 tabbar-ruler-popup-scrollbar nil ; If you want to only show the  scroll bar when your mouse is moving.
)
(require 'tabbar-ruler)



(defmacro defun-prefix-alt (name on-no-prefix on-prefix &optional do-always)
   `(defun ,name (arg)
      (interactive "P")
      ,do-always
      (if (equal nil arg)
  ,on-no-prefix
        ,on-prefix))
)

(defun-prefix-alt shk-tabbar-next (tabbar-forward-tab) (tabbar-forward-group) (tabbar-mode 1))
(defun-prefix-alt shk-tabbar-prev (tabbar-backward-tab) (tabbar-backward-group) (tabbar-mode 1))

;; C-S-<tab> ;; C-S-<win>-<tab>
(global-set-key (kbd "<C-S-iso-lefttab>") 'tabbar-forward-tab)
(global-set-key (kbd "<C-S-s-iso-lefttab>") 'tabbar-backward-tab)
;; C-x C-<left> ;; C-x C-<right>
(global-set-key (kbd "C-x C-<right>") 'tabbar-forward-group)
(global-set-key (kbd "C-x C-<left>") 'tabbar-backward-group)


(provide 'xani-tabbar)
