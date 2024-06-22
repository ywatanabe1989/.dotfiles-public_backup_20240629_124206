(defun my/tab-AI-IELTS ()
  (interactive)
  ;; Init
  (message "my/tab-AI-IELTS")
  (my/term-named "AI IELTS")

  ;; Left
  (find-file "/ssh:ywatanabe@vchat:~/proj/v_chat/")
  (rename-buffer "AI IELTS")
  (split-window-right)
  ;; (my/tab-set-semi-home-buffer) ; should be placed just before other-window

  ;; Right
  (other-window 1)
  (my/term-name "AI IELTS")
  (term-send-raw-string "ssh v_chat\n")
  (term-send-raw-string "cd ~/proj/v_chat")
  (term-send-raw-string "ipython\n")
  (term-send-raw-string "\C-l")
  (my/tab-set-buffer "semi-home")

  ;; Left
  (other-window 1)
  (my/tab-set-buffer "home")
  )

(message "073-my-tab-AI_IELTS.el was loaded.")
