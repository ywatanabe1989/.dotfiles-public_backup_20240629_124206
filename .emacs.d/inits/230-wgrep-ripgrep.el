;; -*- lexical-binding: t -*-
                                        ;
(use-package wgrep
  :ensure t
  :config
  (setq wgrep-enable-key "r")
  (setq wgrep-auto-save-buffer t)
  (setq wgrep-change-readonly-file t))

(defun my/auto-wgrep-enable (&rest _args)
  "Automatically enable `wgrep` mode in `rg-mode` buffers, ignoring any arguments."
  (interactive)
  (set (make-local-variable 'wgrep-auto-save-buffer) t)
  (wgrep-change-to-wgrep-mode))

;; (unless (package-installed-p 'rg)
;;   (package-refresh-contents)
;;   (package-install 'rg))

;; (use-package rg
;;   :ensure t
;;   :config
;;   (defun rg-from-current-directory (keyword)
;;     "Run `rg` with a keyword from the current directory."
;;     (interactive "sEnter keyword: ") ;; Prompts the user to enter a keyword
;;     (rg-run keyword "*.*" default-directory))

;;   ;; Bind C-S-g to the custom `rg` function
;;   (global-set-key (kbd "C-S-g") 'rg-from-current-directory))


(require 'rg)

;; ;; Set up a global key for invoking ripgrep search
;; (global-set-key (kbd "C-c s") 'rg)

;; Configure rg to always search from the project's root if possible
(setq rg-group-result t)
(setq rg-show-columns t)

;; Optionally customize the default directory to always be the current buffer's directory
(defun rg-search-current-directory (keywords)
  "Run ripgrep in the current directory."
  (interactive "sEnter keyword: ")
  (rg-run keywords "*" default-directory))

;; Bind the custom function to a key
(global-set-key (kbd "C-S-g") 'rg-search-current-directory)


(bind-key* (kbd "C-S-h") 'describe-symbol)


;; (use-package rg
;;   :ensure t
;;   :config
;;   (defun rg-from-current-context (keyword)
;;     "Run `rg` with a keyword from the current context.
;; If called in a file buffer, search only within that file. Otherwise, search in the current directory."
;;     (interactive "sEnter keyword: ") ;; Prompts the user to enter a keyword
;;     (if buffer-file-name
;;         ;; If in a file buffer, search only within the current file
;;         (rg-run keyword "*.*" (file-name-directory buffer-file-name) (list (buffer-file-name)))
;;       ;; Otherwise, search in the current directory
;;       (rg-run keyword "*.*" default-directory)))

;;   ;; Bind C-S-g to the custom `rg` function
;;   (global-set-key (kbd "C-S-g") 'rg-from-current-context))
