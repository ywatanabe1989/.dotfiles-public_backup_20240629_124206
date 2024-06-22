(setq my/rippleWM-dir "/home/ywatanabe/proj/siEEG_ripple/")

(defun my/tab-RippleWM ()
  (interactive)
  ;; Init
  (message "my/tab-RippleWM")
  (let ((last-dir-name (file-name-nondirectory (directory-file-name my/rippleWM-dir))))
    (my/term-named last-dir-name)
    ;; Left
    (find-file (concat "/ssh:ywatanabe@444:" my/rippleWM-dir "README.md"))
    (split-window-right)
    (other-window 1)

    ;; Right
    (my/term-name last-dir-name)
    (term-send-raw-string "444 \n")
    (term-send-raw-string (concat "cd " my/rippleWM-dir "\n"))
    (term-send-raw-string "ipy\n")
    (term-send-raw-string "\C-l")
    (my/tab-set-buffer "semi-home")

    ;; Left
    (other-window -1)
    (my/tab-set-buffer "home")
    ))


(defun my/tab-RippleWM-revision ()
  (interactive)
  ;; Init
  (message "my/tab-RippleWM-revision")
  (my/term-named "RippleWM-revision")
  ;; Left
  (find-file "/home/ywatanabe/proj/SciTexRippleWM/revision/main.tex")
  (split-window-right)
  (other-window 1)

  ;; Right
  (find-file "/home/ywatanabe/proj/SciTexRippleWM/revision/src")
  (my/tab-set-buffer "semi-home")

  ;; Left
  (other-window -1)
  (my/tab-set-buffer "home")
  )

(defun my/tab-RippleWM-revision-view ()
  (interactive)
  ;; Init
  (message "my/tab-RippleWM-revision-view")
  (my/term-named "RippleWM-revision-view")
  ;; Left
  (find-file "/home/ywatanabe/proj/SciTexRippleWM/revision/main.tex")
  (latex-preview-pane-mode)
  ;; (split-window-right)
  (other-window 1)

  ;; ;; Right
  ;; (find-file "/home/ywatanabe/proj/SciTexRippleWM/revision/main.pdf")
  (my/tab-set-buffer "semi-home")

  ;; Left
  (other-window -1)
  (my/tab-set-buffer "home")
  )


(defun my/tab-RippleWM-revision-diff ()
  (interactive)
  ;; Init
  (message "my/tab-RippleWM-revision-diff")
  (my/term-named "RippleWM-revision-diff")
  ;; Left
  (find-file "/home/ywatanabe/proj/SciTexRippleWM/diff.tex")
  ;; (latex-preview-pane-mode)
  (split-window-right)
  (other-window 1)

  ;; Right
  ;; (find-file "/home/ywatanabe/proj/SciTexRippleWM/diff.pdf")
  ;; (my/tab-set-buffer "semi-home")

  ;; Left
  (other-window -1)
  (my/tab-set-buffer "home")
  )

(message "075-my-tab-RippleWM.el was loaded.")
