;; Repogitories
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
;; (package-refresh-contents)

;; use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)
; (setq use-package-always-defer t)


(use-package init-loader
  :ensure t ;; Ensure init-loader is installed (optional, requires package.el or similar)
  :init
  ;; Code that runs before init-loader is loaded
  (let ((default-directory (expand-file-name "~/.emacs.d/lisp")))
    (add-to-list 'load-path default-directory)
    (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
        (normal-top-level-add-subdirs-to-load-path)))
  :config
  ;; Code that runs after init-loader is loaded
  (setq init-loader-show-log-after-init nil)
  (setq init-loader-default-regexp "\\(?:^[[:digit:]]\\{2,3\\}\\).*\\.el$")
  (init-loader-load "~/.emacs.d/inits"))
