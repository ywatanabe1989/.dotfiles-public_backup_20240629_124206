;; (require 'emacs-gpt)
;; (add-to-list 'load-path getenv("EMACS_GPT_DIR"))
;; (setq gpt-openai-key (getenv "OPENAI_API_KEY"))
;; (setq gpt-openai-engine "gpt-4-turbo")
;; (setq gpt-script-path "/home/ywatanabe/.emacs.d/lisp/emacs-gpt/emacs-gpt.py")
;; (setq gpt-openai-max-tokens "2000")
;; (setq gpt-openai-temperature "0")

;; ;; Key binndings
;; (define-key global-map (kbd "M-C-g") 'gpt-on-region)
;; (define-key global-map (kbd "M-S-C-g") 'gpt-clear-history)

;; (message "340-gpt.el was loaded.")
