;; init config
(require 'package)
;; speed up startup
(setq package-enable-at-startup nil)
;; repo
(setq package-archives '(("org"       . "https://orgmode.org/elpa/")
                         ("gnu"       . "https://elpa.gnu.org/packages/")
                         ("melpa"     . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ;; Maintainer is AWOL.
                         ;; ("marmalade" . "https://marmalade-repo.org/packages/")
                         ))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
;;(require 'diminish)                ;; if you use :diminish
(require 'bind-key)                ;; if you use any :bind variant
;;(require 'use-package)

(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/todo/gtd/gtd.org" "~/todo/gtd/tickler.org")))
 '(package-selected-packages
   (quote
    (ox-gfm google-c-style dash-at-point counsel ace-jump-mode yasnippet use-package))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :family "Inconsolata")))))
