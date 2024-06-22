;; -*- lexical-binding: t -*-
(defvar my/tab-buffer-alist nil
  "Alist buffer types.")

(use-package company
  :ensure t
  )

(use-package tab-bar
  :ensure t
  :init
  (tab-bar-mode t)
  :custom
  (tab-bar-show t)
  (tab-bar-tab-hints t)
  (tab-bar-name-truncated t)
  (tab-bar-auto-width nil)
  ;; (tab-bar-new-tab-to 'rightmost)
  (tab-bar-new-tab-to 'right)
  (setq tab-bar-close-button-show nil)
  (custom-set-faces
   '(tab-bar ((t (:background "gray20" :foreground "white"))))
   '(tab-bar-tab ((t (:inherit tab-bar :background "gray40" :foreground "dark orange"))))
   '(tab-bar-tab-inactive ((t (:inherit tab-bar :background "gray20" :foreground "gray80")))))
  )


;; Functions
(defun my/term-named (arg)
  ;; (defun my/tab-new (arg)
  (interactive
   (list
    (read-string "Enter string: ")))
  (tab-new)
  (tab-rename (message "%s" arg))
  )

(defun my/tab-set-buffer (type &optional tab-name buffer-name)
  "Set a buffer as either home or semi-home for a given tab."
  (interactive "sType (home/semi-home): ")
  ;; Validate type
  (unless (member type '("home" "semi-home"))
    (error "Type must be either 'home' or 'semi-home'"))
  ;; Use current tab's name if TAB-NAME is not provided.
  (unless tab-name
    (setq tab-name (alist-get 'name (tab-bar--current-tab))))
  ;; (setq tab-name (alist-get 'name (car (last (tab-bar-tabs))))))
  ;; Use current buffer's name if BUFFER-NAME is not provided.
  (unless buffer-name
    (setq buffer-name (buffer-name)))
  ;; Ensure the buffer exists.
  (get-buffer-create buffer-name)
  ;; Find or create tab entry in alist.
  (let ((tab-entry (assoc tab-name my/tab-buffer-alist)))
    (if tab-entry
        ;; Update existing tab entry.
        (setcdr tab-entry (cons (cons type buffer-name) (assoc-delete-all type (cdr tab-entry))))
      ;; Add new tab entry.
      (push (cons tab-name (list (cons type buffer-name))) my/tab-buffer-alist)))
  (message "The %s buffer of tab \"%s\" is set as \"%s\"" type tab-name buffer-name))

(defun my/tab-get-buffer (type &optional tab)
  "Get the buffer of a given type (home or semi-home) associated with a tab."
  (interactive "sType (home/semi-home): ")
  ;; Use the current tab if none is specified.
  (unless tab (setq tab (tab-bar--current-tab)))
  (let* ((tab-name (alist-get 'name tab))
         (tab-entry (assoc tab-name my/tab-buffer-alist))
         (buffer-entry (assoc type (cdr tab-entry))))
    (cdr buffer-entry)))

(defun my/tab-jump-to-buffer (type)
  "Jump to the buffer of a given type associated with the current tab."
  (interactive "sType (home/semi-home): ")
  (let ((buffer (my/tab-get-buffer type)))
    (if buffer
        (progn
          (switch-to-buffer buffer)
          (message "Switched to %s buffer." type))
      (message "No %s buffer set for this tab" type))))

(defun my/tab-describe-buffer-alist ()
  "Print each (tab-name . buffer-alist) pair in `my/tab-buffer-alist`."
  (interactive)
  (message "%s" (mapconcat (lambda (pair)
                             (format "%s: %s" (car pair) (mapconcat (lambda (bp)
                                                                      (format "%s: %s" (car bp) (cdr bp)))
                                                                    (cdr pair) ", ")))
                           my/tab-buffer-alist
                           ", ")))

(defun my/tab-is-any-buffer (type)
  "Check if the current buffer is of a given type (home or semi-home) in any tab."
  (let ((current-buffer-name (buffer-name))
        (found nil))
    (dolist (tab-entry my/tab-buffer-alist found)
      (when (string= (cdr (assoc type (cdr tab-entry))) current-buffer-name)
        (setq found t)))
    found))

(defun my/tab-jump-to (index)
  "Jump to the tab at the specified INDEX."
  (interactive "p")
  (tab-bar-select-tab index))

(defun my/tab-move (&optional step)
  "Move to the next tab, or move STEP tabs if specified."
  (interactive
   (list (if current-prefix-arg
             (prefix-numeric-value current-prefix-arg)
           (read-number "Enter step: " 1))))
  (tab-move step))

(defun my/tab-remove-1 ()
  (interactive)
  (my/tab-jump-to 1)
  (tab-close)
  )


;; Bindings
;; tab-bar-mode
(define-prefix-command 'my/tab-bar-mode)
(global-set-key (kbd "M-t") 'my/tab-bar-mode)
(define-key my/tab-bar-mode (kbd "0") 'tab-close)
(define-key my/tab-bar-mode (kbd "1") 'tab-close-other)
(define-key my/tab-bar-mode (kbd "2") 'my/term-named)
(define-key my/tab-bar-mode (kbd "n") 'my/term-named)
(define-key my/tab-bar-mode (kbd "m") 'my/tab-move)
(define-key my/tab-bar-mode (kbd "r") 'tab-rename)
(define-key my/tab-bar-mode (kbd "d") 'my/tab-describe-buffer-alist)
(define-key my/tab-bar-mode (kbd "h") (lambda () (interactive) (my/tab-set-buffer "home")))
(define-key my/tab-bar-mode (kbd "s") (lambda () (interactive) (my/tab-set-buffer "semi-home")))

(define-key image-mode-map (kbd "h") (lambda () (interactive) (my/tab-set-buffer "home")))
(define-key image-mode-map (kbd "s") (lambda () (interactive) (my/tab-set-buffer "semi-home")))

;; Global
(global-unset-key (kbd "C-1"))
(global-unset-key (kbd "C-2"))
(global-unset-key (kbd "C-3"))
(global-unset-key (kbd "C-4"))
(global-unset-key (kbd "C-5"))
(global-unset-key (kbd "C-6"))
(global-unset-key (kbd "C-7"))
(global-unset-key (kbd "C-8"))
(global-unset-key (kbd "C-9"))

(define-key global-map (kbd "C-1") (lambda () (interactive) (my/tab-jump-to 1)))
(define-key global-map (kbd "C-2") (lambda () (interactive) (my/tab-jump-to 2)))
(define-key global-map (kbd "C-3") (lambda () (interactive) (my/tab-jump-to 3)))
(define-key global-map (kbd "C-4") (lambda () (interactive) (my/tab-jump-to 4)))
(define-key global-map (kbd "C-5") (lambda () (interactive) (my/tab-jump-to 5)))
(define-key global-map (kbd "C-6") (lambda () (interactive) (my/tab-jump-to 6)))
(define-key global-map (kbd "C-7") (lambda () (interactive) (my/tab-jump-to 7)))
(define-key global-map (kbd "C-8") (lambda () (interactive) (my/tab-jump-to 8)))
(define-key global-map (kbd "C-9") (lambda () (interactive) (my/tab-jump-to 9)))

;; (define-key global-map (kbd "M-1") (lambda () (interactive) (my/tab-jump-to 1)))
;; (define-key global-map (kbd "M-2") (lambda () (interactive) (my/tab-jump-to 2)))
;; (define-key global-map (kbd "M-3") (lambda () (interactive) (my/tab-jump-to 3)))
;; (define-key global-map (kbd "M-4") (lambda () (interactive) (my/tab-jump-to 4)))
;; (define-key global-map (kbd "M-5") (lambda () (interactive) (my/tab-jump-to 5)))
;; (define-key global-map (kbd "M-6") (lambda () (interactive) (my/tab-jump-to 6)))
;; (define-key global-map (kbd "M-7") (lambda () (interactive) (my/tab-jump-to 7)))
;; (define-key global-map (kbd "M-8") (lambda () (interactive) (my/tab-jump-to 8)))
;; (define-key global-map (kbd "M-9") (lambda () (interactive) (my/tab-jump-to 9)))

;; (define-key global-map (kbd "M-h") (lambda () (interactive) (my/tab-jump-to-buffer "home")))
;; (define-key global-map (kbd "M-H") (lambda () (interactive) (my/tab-set-buffer "home")))
;; (define-key global-map (kbd "M-s") (lambda () (interactive) (my/tab-jump-to-buffer "semi-home")))
;; (define-key global-map (kbd "M-S") (lambda () (interactive) (my/tab-set-buffer "semi-home")))
(use-package bind-key
  :ensure t)

(bind-key* (kbd "M-1") (lambda () (interactive) (my/tab-jump-to 1)))
(bind-key* (kbd "M-2") (lambda () (interactive) (my/tab-jump-to 2)))
(bind-key* (kbd "M-3") (lambda () (interactive) (my/tab-jump-to 3)))
(bind-key* (kbd "M-4") (lambda () (interactive) (my/tab-jump-to 4)))
(bind-key* (kbd "M-5") (lambda () (interactive) (my/tab-jump-to 5)))
(bind-key* (kbd "M-6") (lambda () (interactive) (my/tab-jump-to 6)))
(bind-key* (kbd "M-7") (lambda () (interactive) (my/tab-jump-to 7)))
(bind-key* (kbd "M-8") (lambda () (interactive) (my/tab-jump-to 8)))
(bind-key* (kbd "M-9") (lambda () (interactive) (my/tab-jump-to 9)))
(bind-key* (kbd "M-h") (lambda () (interactive) (my/tab-jump-to-buffer "home")))
(bind-key* (kbd "M-H") (lambda () (interactive) (my/tab-set-buffer "home")))
(bind-key* (kbd "M-s") (lambda () (interactive) (my/tab-jump-to-buffer "semi-home")))
(bind-key* (kbd "M-S") (lambda () (interactive) (my/tab-set-buffer "semi-home")))

(define-key global-map (kbd "M-1") (lambda () (interactive) (my/tab-jump-to 1)))
(define-key global-map (kbd "M-2") (lambda () (interactive) (my/tab-jump-to 2)))
(define-key global-map (kbd "M-3") (lambda () (interactive) (my/tab-jump-to 3)))
(define-key global-map (kbd "M-4") (lambda () (interactive) (my/tab-jump-to 4)))
(define-key global-map (kbd "M-5") (lambda () (interactive) (my/tab-jump-to 5)))
(define-key global-map (kbd "M-6") (lambda () (interactive) (my/tab-jump-to 6)))
(define-key global-map (kbd "M-7") (lambda () (interactive) (my/tab-jump-to 7)))
(define-key global-map (kbd "M-8") (lambda () (interactive) (my/tab-jump-to 8)))
(define-key global-map (kbd "M-9") (lambda () (interactive) (my/tab-jump-to 9)))
(define-key global-map (kbd "M-h") (lambda () (interactive) (my/tab-jump-to-buffer "home")))
(define-key global-map (kbd "M-H") (lambda () (interactive) (my/tab-set-buffer "home")))
(define-key global-map (kbd "M-s") (lambda () (interactive) (my/tab-jump-to-buffer "semi-home")))
(define-key global-map (kbd "M-S") (lambda () (interactive) (my/tab-set-buffer "semi-home")))


(message "070-tab-bar-mode.el was loaded")
