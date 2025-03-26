;; Eglot Configuration for Emacs

;; Enable Eglot for multiple programming languages
(use-package eglot
  :ensure t  ; Ensure the package is installed
  :hook (
    ;; Automatically start Eglot for these major modes
    (python-mode . eglot-ensure)
    (javascript-mode . eglot-ensure)
    (typescript-mode . eglot-ensure)
    (rust-mode . eglot-ensure)
    (go-mode . eglot-ensure)
    (c-mode . eglot-ensure)
    (c++-mode . eglot-ensure)
    (java-mode . eglot-ensure)
  )
  :config
  ;; Custom server configurations
  (add-to-list 'eglot-server-programs
    '(
      ;; Python: pyright or pylsp
      (python-mode . ("pyright-langserver" "--stdio"))
      ;; JavaScript/TypeScript: typescript-language-server
      ((javascript-mode typescript-mode) . ("typescript-language-server" "--stdio"))
      ;; Rust: rust-analyzer
      (rust-mode . ("rust-analyzer"))
      ;; Go: gopls
      (go-mode . ("gopls"))
      ;; C/C++: clangd
      ((c-mode c++-mode) . ("clangd"))
      ;; Java: eclipse.jdt.ls
      (java-mode . ("jdtls"))
    )
  )

  ;; Optional: Custom settings for Eglot
  (setq 
    ;; Disable eldoc on hover (optional)
    ;; eglot-ignored-server-capabilities '(:hoverProvider)
    
    ;; Configure completion styles
    completion-category-overrides '((eglot (styles basic)))
    
    ;; Optional: Highlight references
    eglot-highlight-symbol-face 'highlight
  )
)

;; Optional: Additional LSP-related configurations
(use-package flymake
  :hook (eglot-managed-mode . flymake-mode)
)

;; Optional: Enhanced completion with company-mode
(use-package company
  :after eglot
  :hook (eglot-managed-mode . company-mode)
  :config
  (setq 
    company-minimum-prefix-length 1
    company-idle-delay 0.1
  )
)
