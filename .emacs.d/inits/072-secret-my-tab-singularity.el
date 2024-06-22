(defun my/tab-singularity ()
  (interactive)
  ;; Init
  (message "my/tab-singularity")
  (my/term-named "Singularity")

  ;; Left
  (find-file "/ssh:ywatanabe@g06:~/proj/singularity_template/README.md")
  (rename-buffer "Singularity")
  (split-window-right)

  ;; Right
  (other-window 1)
  (my/term-name "Singularity")
  (term-send-raw-string "g06\n")
  (term-send-raw-string "cd ~/proj/singularity_template \n")
  ;; (term-send-raw-string "ipython\n")
  (term-send-raw-string "\C-l")
  (my/tab-set-buffer "semi-home")

  ;; Left
  (other-window 1)
  (my/tab-set-buffer "home")
  )
