(defun my/tab-pacnet ()
  (interactive)
  ;; Init
  (message "my/tab-pacnet")
  (my/term-named "PACNet")

  ;; Left
  (find-file "/ssh:ywatanabe@444:~/proj/entrance/PACNet/README.md")
  (rename-buffer "PACNet")
  (split-window-right)

  ;; Right
  (other-window 1)
  (my/term-name "PACNet")
  (term-send-raw-string "444\n")
  (term-send-raw-string "cd ~/proj/entrance/PACNet")
  (term-send-raw-string "ipython\n")
  (term-send-raw-string "\C-l")
  (my/tab-set-buffer "semi-home")

  ;; Left
  (other-window 1)
  (my/tab-set-buffer "home")
  )
