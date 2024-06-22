(setq my/mngs-dir "/home/ywatanabe/mngs_repo/src/mngs/")
(setq my/mngs-machine "")

(defun my/tab-mngs ()
  (interactive)
  ;; Init
  (message "my/tab-mngs")
  (my/term-named "mngs")

  ;; Left
  (find-file (concat my/mngs-machine my/mngs-dir))
  (split-window-right)

  ;; Right
  (other-window 1)
  (my/term-name "mngs")
  (term-send-raw-string (concat "cd " my/mngs-dir "\n"))
  (term-send-raw-string "clear\n")
  (my/tab-set-buffer "semi-home")

  ;; Left
  (other-window -1)
  (my/tab-set-buffer "home")
  )

(message "081-my-tab-mngs.el was loaded.")
