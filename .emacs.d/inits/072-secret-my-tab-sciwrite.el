(defun my/tab-sciwrite ()
  (interactive)
  ;; Init
  (message "my/tab-sciwrite")
  (my/term-named "sciwrite")

  ;; Left
  ;; (find-file "/ssh:ywatanabe@sciwrite:~/proj/sciwriter/")
  (find-file "~/proj/sciwriter/")
  (rename-buffer "sciwrite")
  (split-window-right)
  ;; (my/tab-set-semi-home-buffer) ; should be placed just before other-window

  ;; Right
  (other-window 1)
  (my/term-name "sciwrite")
  (term-send-raw-string "sciwrite\n")
  (term-send-raw-string "cd ~/proj/sciwriter")
  (term-send-raw-string "ipython\n")
  (term-send-raw-string "\C-l")
  (my/tab-set-buffer "semi-home")

  ;; Left
  (other-window 1)
  (my/tab-set-buffer "home")
  )

(defun my/tab-sciwrite-8939 ()
  (interactive)
  ;; Init
  (message "my/tab-sciwrite")
  (my/term-named "sciwrite")

  ;; Left
  (find-file "/ssh:ywatanabe@sciwrite:~/proj/sciwriter/")
  ;; (find-file "~/proj/sciwriter/")
  (rename-buffer "sciwrite")
  (split-window-right)
  ;; (my/tab-set-semi-home-buffer) ; should be placed just before other-window

  ;; Right
  (other-window 1)
  (my/term-name "sciwrite")
  (term-send-raw-string "sciwrite\n")
  (term-send-raw-string "cd ~/proj/sciwriter")
  (term-send-raw-string "ipython\n")
  (term-send-raw-string "\C-l")
  (my/tab-set-buffer "semi-home")

  ;; Left
  (other-window 1)
  (my/tab-set-buffer "home")
  )
