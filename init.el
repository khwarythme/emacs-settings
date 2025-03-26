;; Personal Emacs Configuration

;; Package management
(require 'package)
(add-to-list 'package-archives 
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Use-package for better package management
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Basic UI improvements
(setq inhibit-startup-message t)  ; Remove welcome screen
(tool-bar-mode -1)                ; Disable toolbar
(menu-bar-mode -1)                ; Disable menu bar
(scroll-bar-mode -1)              ; Disable scrollbar
(global-display-line-numbers-mode 1)  ; Show line numbers
(column-number-mode t)            ; Show column number in mode line

;; Theme
(use-package doom-themes
  :config
  (load-theme 'doom-one t))

;; Autocomplete framework
(use-package company
  :config
  (global-company-mode t)
  (setq company-idle-delay 0.2)
  (setq company-minimum-prefix-length 1))

;; Improved search and navigation
(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t))

;; Enhanced M-x
(use-package counsel
  :config
  (counsel-mode 1))

;; Git integration
(use-package magit
  :bind ("C-x g" . magit-status))

;; Highlight matching parentheses
(show-paren-mode 1)

;; Backup and autosave settings
(setq backup-directory-alist '(("." . "~/.emacs.d/backups"))
      backup-by-copying t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; Smooth scrolling
(setq scroll-step 1
      scroll-conservatively 10000)

;; Tabs and indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Enable y/n answers
(defalias 'yes-or-no-p 'y-or-n-p)

;; Custom keybindings
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "M-/") 'hippie-expand)

;; Save customizations to a separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(load-file  "~/.emacs.d/tree.el")
(load-file "~/.emacs.d/eglot.el")
(load-file "~/.emacs.d/org.el")
(load-file "~/.emacs.d/proxy.el")
