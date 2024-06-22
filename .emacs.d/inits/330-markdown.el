(use-package markdown-mode
  :mode ("\\.md\\'" . gfm-mode)
  :config
  (setq markdown-command "/usr/bin/pandoc")
  (setq markdown-open-command "/usr/bin/pandoc")
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
  ;; (unbind-key "C-c C-a" markdown-mode-map))
  (define-key markdown-mode-map (kbd "C-t") 'my/org-agenda))


;; Markdown Mode
;; (autoload 'markdown-mode "markdown-mode"
;;    "Major mode for editing Markdown files" t)
;; (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

;; (autoload 'markdown-preview-mode "markdown-preview-mode.el" t)

(defun my/markdown-live-preview-buffer (newwindow)
  "Toggle Markdown live preview in a separate buffer."
  (interactive "P")
  (if newwindow
      (markdown-live-preview-window)
    (markdown-live-preview-mode)))

(remove-hook 'markdown-mode-hook #'enable-trailing-whitespace)
(remove-hook 'gfm-mode-hook #'enable-trailing-whitespace)

(setq markdown-fontify-code-blocks-natively t)
