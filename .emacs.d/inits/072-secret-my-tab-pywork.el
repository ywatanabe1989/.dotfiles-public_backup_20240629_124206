(setq my/python-workdir "/home/ywatanabe/proj/entrance/neurovista/")

(defun my/tab-neurovista ()
  (interactive)
  ;; Init
  (message "my/tab-neurovista")
  (let ((last-dir-name (file-name-nondirectory (directory-file-name my/python-workdir))))
    (my/term-named last-dir-name)
    ;; Left
    (find-file (concat "/ssh:ywatanabe@444:" my/python-workdir "README.md"))
    (split-window-right)
    (other-window 1)

    ;; Right
    (my/term-name last-dir-name)
    ;; (my/term-send-command "444")
    (term-send-raw-string "444\n")
    (term-send-raw-string (concat "cd " my/python-workdir "\n"))
    (term-send-raw-string "ipython\n")
    (term-send-raw-string "\C-l")
    (my/tab-set-buffer "semi-home")

    ;; Left
    (other-window -1)
    (my/tab-set-buffer "home")
  ))
