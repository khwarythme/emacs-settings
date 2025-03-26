;;; Org-mode Configuration

;; Enable Org-mode
(require 'org)
(require 'org-keys)

;; Basic Org-mode settings
(setq org-directory "~/org/")
(setq org-default-notes-file (concat org-directory "inbox.org"))

;; Capture templates
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Inbox")
         "* TODO %?\n  %i\n  %a")
        ("n" "Notes" entry (file+headline "~/org/notes.org" "Notes")
         "* %?\n  %i\n  %U")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %i")))

;; TODO keywords and state tracking
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

;; Agenda configuration
(setq org-agenda-files (list org-directory))
(setq org-agenda-span 'week)
(setq org-agenda-start-on-weekday nil)

;; Refile settings
(setq org-refile-targets 
      '((org-agenda-files :maxlevel . 3)))
(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)

;; Logging and tracking
(setq org-log-done 'time)
(setq org-log-into-drawer t)

;; Priorities
(setq org-priority-highest ?A)
(setq org-priority-lowest ?C)
(setq org-priority-default ?B)

;; Custom Keymaps for Org-mode
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c l") 'org-store-link)

;; Org-mode specific keymaps
(define-key org-mode-map (kbd "C-c d") 'org-deadline)
(define-key org-mode-map (kbd "C-c s") 'org-schedule)
(define-key org-mode-map (kbd "C-c p") 'org-priority)

;; Custom functions with keybindings
(defun my/org-archive-done-tasks ()
  "Archive all DONE tasks."
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (outline-previous-heading)))
   "/DONE" 'file))
(global-set-key (kbd "C-c x") 'my/org-archive-done-tasks)

;; Quick task state changes
(defun my/org-quick-todo ()
  "Quickly change TODO state."
  (interactive)
  (org-todo 'right))
(define-key org-mode-map (kbd "C-c t") 'my/org-quick-todo)

;; Enhanced task management keybindings
(defun my/org-open-inbox ()
  "Open the Org inbox file."
  (interactive)
  (find-file org-default-notes-file))
(global-set-key (kbd "C-c i") 'my/org-open-inbox)

;; Tags navigation
(define-key org-mode-map (kbd "C-c g") 'org-tags-view)

;; Additional existing configurations...
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (shell . t)
   (emacs-lisp . t)
   (C . t)
   (js . t)
   (sql . t)))

;; Allow evaluation of certain languages
(setq org-confirm-babel-evaluate nil)

;; Export settings
(setq org-export-backends '(ascii html latex md))

;; Archiving
(setq org-archive-location 
      (concat org-directory "archive/%s_archive::* Archived Tasks"))

;; Clocking configuration
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

;; Custom agenda views
(setq org-agenda-custom-commands
      '(("w" "Work agenda"
         ((agenda "")
          (tags-todo "work")
          (tags-todo "meeting")))
        ("p" "Personal agenda"
         ((agenda "")
          (tags-todo "personal")))))

;; Habit tracking
(require 'org-habit)
(setq org-habit-graph-column 60)
(setq org-habit-show-habits-only-for-today t)

;; Visual enhancements
(setq org-startup-indented t)
(setq org-pretty-entities t)
(setq org-hide-emphasis-markers t)

;; Link handling
(setq org-return-follows-link t)

(provide 'org-mode-config)
;;; org-mode-config.el ends here
