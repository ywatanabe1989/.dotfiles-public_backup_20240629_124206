;; (use-package magit)
;; package-install magit
(when (executable-find "git")
   (require 'magit nil t))
(setq projectile-mode-line "Projectile")
(setq remote-file-name-inhibit-cache nil)
(setq vc-ignore-dir-regexp
      (format "%s\\|%s"
                    vc-ignore-dir-regexp
                    tramp-file-name-regexp))
(setq tramp-verbose 1)
;; git-gutter
;; git-gutter-fringe
;; git-gutter++
;; (require 'magit-gh-pulls)
