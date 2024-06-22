(defun my/tab-chat ()
  (interactive)
  ;; Init
  (message "my/tab-chat")
  (my/term-named "chat")
  ;; Left
  (find-file "~/proj/chat")
  (split-window-right)
  (other-window 1)

  ;; Right
  (my/term-name "chat")
  (term-send-raw-string "ipython\n")
  (term-send-raw-string "\C-l")
  (my/tab-set-buffer "semi-home")

  ;; Left
  (other-window -1)
  (my/tab-set-buffer "home")
  )
