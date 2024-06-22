(defun my/tab-scratch-message ()
  (interactive)
  ;; Init
  (message "my/tab-scratch-message")
  (my/term-named "cheet & message")

  ;; Left
  (find-file "~/.emacs.d/cheet_sheets/regexp.md")
  (rename-buffer "regexp-cheat")
  ;; (switch-to-buffer "*scratch*")
  (split-window-right)
  ;; (my/tab-set-semi-home-buffer) ; should be placed just before other-window

  ;; Right
  (other-window 1)
  (switch-to-buffer "*Messages*")
  (my/tab-set-buffer "semi-home")

  ;; Left
  (other-window 1)
  (my/tab-set-buffer "home")
  )
