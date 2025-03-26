;;; Treemacs Configuration

;; Install treemacs if not already installed
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  
  :config
  ;; General Treemacs settings
  (setq treemacs-follow-after-init          t
        treemacs-width                      35
        treemacs-indentation                2
        treemacs-git-mode                   'deferred
        treemacs-is-never-other-window      nil
        treemacs-show-hidden-files          t
        treemacs-silent-filewatch           nil
        treemacs-silent-refresh             nil
        treemacs-sorting                    'alphabetic-asc
        treemacs-space-between-root-nodes  t
        treemacs-tag-follow-mode           t)

  ;; Projectile integration
  (use-package treemacs-projectile
    :after (treemacs projectile)
    :ensure t)

  ;; Magit integration
  (use-package treemacs-magit
    :after (treemacs magit)
    :ensure t)

  ;; LSP integration
  (use-package lsp-treemacs
    :after (treemacs lsp-mode)
    :ensure t
    :config
    (lsp-treemacs-sync-mode 1))

  ;; Custom keybindings
  (global-set-key (kbd "C-x t t") 'treemacs)
  (global-set-key (kbd "C-x t 1") 'treemacs-select-window)
  (global-set-key (kbd "C-x t B") 'treemacs-bookmark)
  (global-set-key (kbd "C-x t C-t") 'treemacs-find-file)

  ;; Customize appearance
  (treemacs-load-theme "Default")

  ;; Auto-hide/show settings
  (defun my/treemacs-auto-hide ()
    "Hide Treemacs when no project is open."
    (unless (treemacs-current-workspace)
      (treemacs-delete-other-windows)))

  (add-hook 'kill-buffer-hook #'my/treemacs-auto-hide)

  ;; Load treemacs on startup (optional)
  ;; Uncomment if you want Treemacs to open automatically
  ;; (treemacs)
)

;; Ensure treemacs is loaded
(require 'treemacs)
