(defvar my/ylab-host "g08" "")

(defun my/tab-setup ()
  (interactive)
  ;; (my/tab-org)

  ;; websites
  ;; (my/tab-sciwrite)
  ;; (my/tab-AI-IELTS)
  ;; (my/tab-chat)

  ;; RippleWM
  ;; (my/tab-RippleWM) ; #
  ;; (my/tab-RippleWM-revision)
  ;; (my/tab-RippleWM-revision-view)
  ;; (my/tab-RippleWM-revision-diff)


  ;; (my/tab-devin)

  ;; (my/tab-neurovista)
  ;; (my/tab-results)
  ;; (my/tab-resource)
  (my/tab-bashd)
  (my/tab-inits)
  (my/tab-mngs)
  (my/tab-singularity)
  ;; (my/tab-scratch-message)

  ;; Removes the first tab
  (my/tab-remove-1)
  (my/tab-jump-to 1))



(message "071-my-tabs.el was loaded.")
