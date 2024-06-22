(defun my/tab-opendevin ()
  (interactive)
  ;; Init
  (message "my/tab-opendevin")
  (my/term-named "opendevin")

  ;; Left
  ;; (find-file "/ssh:ywatanabe@opendevin:~/proj/opendevinr/")
  (find-file "~/proj/opendevin/")
  (rename-buffer "opendevin")
  (split-window-right)
  ;; (my/tab-set-semi-home-buffer) ; should be placed just before other-window

  ;; Right
  (other-window 1)
  (my/term-name "opendevin")
  (term-send-raw-string "cd ~/proj/opendevinr")
  (term-send-raw-string "ipython\n")
  (term-send-raw-string "\C-l")
  (my/tab-set-buffer "semi-home")

  ;; Left
  (other-window 1)
  (my/tab-set-buffer "home")
  )
