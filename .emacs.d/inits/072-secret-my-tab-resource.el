(defun my/tab-resource ()
  (interactive)
  ;; Init
  (message "my/tab-resource")
  (my/term-named "resource")

  ;; Left
  (my/term-name "CPU")
  (term-send-raw-string "444\n")
  (term-send-raw-string "htop\n")

  ;; (my/term-send-command "444")
  ;; (my/term-send-command "htop")
  ;; (split-window-right)
  (split-window-below)
  ;; (my/tab-set-buffer "semi-home")
  (other-window 1)

  ;; Right
  (my/term-name "GPU")
  (term-send-raw-string "444\n")
  (term-send-raw-string "ns\n")
  ;; (my/term-send-command "444")
  ;; (my/term-send-command "ns")
  (my/tab-set-buffer "semi-home")

  ;; Left
  (other-window -1)
  (my/tab-set-buffer "home")
  )
