;; [[file:~/.emacs.d/myinit.org::*Basic][Basic:1]]
(setq python-shell-interpreter "/usr/local/opt/python@3.8/bin/python3")
;;personal information
(setq user-full-name "Yang Shen")
(setq user-mail-address "yangfields@gmail.com")
;;set locale, use English
(setq system-time-locale "C")
;;close the welcome interface
(setq inhibit-startup-message t)
;;disable Ctrl+Space and use it as input method
(global-set-key (kbd "C-SPC") 'nil)
;;set no backup files
(setq make-backup-files nil)
;;set a big kill ring
(setq kill-ring-max 200)
;;set fill-column, the maximum characters each line
(setq default-fill-column 72)
;;move the mouse to avoid typing occlusion
(mouse-avoidance-mode 'animate)
;;use y/n to replace yes/no
(fset 'yes-or-no-p 'y-or-n-p)
;;support copy/paste from external program
(setq x-select-enable-clipboard t)
;;enable emacs to open pictures
(auto-image-file-mode)
;;highlight fonts
(global-font-lock-mode t)
;;highlight chosed region
(transient-mark-mode t)
;;only render current screen highlight (speed up)
(setq lazy-lock-defer-on-scrolling t)
(setq font-lock-maximum-decoration t)
;;show title, buffer path, page percentage
(setq frame-title-format "%f")
;;remove scroll bar
(set-scroll-bar-mode nil)
;;open line and column number
(global-linum-mode)
(setq column-number-mode t)
;;match parentheses
(show-paren-mode t)
(setq show-paren-style 'parentheses)
;;enable some functions which are disabled default
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'LaTeX-hide-environment 'disabled nil)
;;transparency
(set-frame-parameter (selected-frame) 'alpha (list 90 50));
(add-to-list 'default-frame-alist (cons 'alpha (list 90 50)))
;; switch window
(global-set-key [M-left] 'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up] 'windmove-up)
(global-set-key [M-down] 'windmove-down)
;;close current buffer
(global-set-key (kbd "C-x 4") 'delete-window)
;;comment code
(global-set-key [?\C-c ?\C-/] 'comment-or-uncomment-region)
(defun my-comment-or-uncomment-region (beg end &optional arg)  
(interactive (if (use-region-p)  
                 (list (region-beginning) (region-end) nil)  
               (list (line-beginning-position)  
                     (line-beginning-position 2))))  
		     (comment-or-uncomment-region beg end arg)  
		     )  
(global-set-key [remap comment-or-uncomment-region] 'my-comment-or-uncomment-region)
(defun open-eshell-other-buffer ()
       (interactive)
       (split-window-vertically)
       (eshell))
(global-set-key [(f1)] 'open-eshell-other-buffer)
;; Basic:1 ends here

;; [[file:~/.emacs.d/myinit.org::*ido][ido:1]]
;; (setq ido-enable-flex-matching t)
;; (setq ido-everywhere t)
;; (ido-mode 1)
(use-package ido                        ; Better minibuffer completion
:init (progn
      (ido-mode)
      (ido-everywhere))
      :config
      (setq ido-enable-flex-matching t      ; Match characters if string doesn't match
      ido-create-new-buffer 'always   ; Create a new buffer if nothing matches
      ido-use-filename-at-point 'guess
      ;; Visit buffers and files in the selected window
      ido-default-file-method 'selected-window
      ido-default-buffer-method 'selected-window
      ido-use-faces nil))             ; Prefer flx ido faces
;; ido:1 ends here

;; [[file:~/.emacs.d/myinit.org::*ivy%20+%20conunsel%20+%20swiper][ivy + conunsel + swiper:1]]
(use-package counsel
  :after ivy
  :config (counsel-mode))

(use-package ivy
  :defer 0.1
  :diminish
  :bind (("C-c C-r" . ivy-resume)
         ("C-x B" . ivy-switch-buffer-other-window))
  :config
  (setq ivy-use-virtual-buffers t
        ivy-count-format "(%d/%d) ")
  (ivy-mode 1))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper)))
;; ivy + conunsel + swiper:1 ends here

;; [[file:~/.emacs.d/myinit.org::*smex][smex:1]]
(use-package smex
  :ensure t
  :bind ("M-x" . smex))
;; smex:1 ends here

;; [[file:~/.emacs.d/myinit.org::*color%20theme%20+%20modeline][color theme + modeline:1]]
(use-package monokai-pro-theme
  :ensure t
  :config (load-theme 'monokai-pro t))

(use-package doom-modeline
    :ensure t
    :hook (after-init . doom-modeline-mode))
;; color theme + modeline:1 ends here

;; [[file:~/.emacs.d/myinit.org::*ace-jump][ace-jump:1]]
(use-package ace-jump-mode
:bind ("C-c SPC" . ace-jump-mode))
;; ace-jump:1 ends here

;; [[file:~/.emacs.d/myinit.org::*company][company:1]]
(use-package company               
:ensure t
:defer t
:init (global-company-mode)
:config
(progn
  ;; Use Company for completion
  (bind-key [remap completion-at-point] #'company-complete company-mode-map)

  (setq company-tooltip-align-annotations t
        ;; Easy navigation to candidates with M-<n>
        company-show-numbers t)
  (setq company-dabbrev-downcase nil))
:diminish company-mode)
;; company:1 ends here

;; [[file:~/.emacs.d/myinit.org::*ycmd%20+%20company-ycmd%20+%20flycheck-ycmd][ycmd + company-ycmd + flycheck-ycmd:1]]
(use-package ycmd
:ensure t
:init (add-hook 'after-init-hook #'global-ycmd-mode)
;; (add-hook 'c++-mode-hook #'ycmd-mode)
:config
(set-variable 'ycmd-server-command '("/usr/local/opt/python@3.8/bin/python3" "/Users/yang/Documents/ycmd/ycmd/"))
(set-variable 'ycmd-global-config "/Users/yang/Documents/ycmd/examples/.ycm_extra_conf.py"))

;; (set-variable 'ycmd-extra-conf-whitelist '("~/todo/*")))

(use-package company-ycmd
:ensure t
:init (company-ycmd-setup)
:config 
(add-hook 'after-init-hook #'global-company-mode))
;;(add-to-list 'company-backends (company-mode/backend-with-yas 'company-ycmd)))

(use-package flycheck-ycmd
:ensure t
:init (flycheck-ycmd-setup)
:config 
(add-hook 'after-init-hook #'global-flycheck-mode))
;;(add-hook 'ycmd-mode-hook 'flycheck-ycmd-setup))
(setq company-idle-delay 0)
;; ycmd + company-ycmd + flycheck-ycmd:1 ends here

;; [[file:~/.emacs.d/myinit.org::*flycheck][flycheck:1]]
(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :init (global-flycheck-mode t))
;; flycheck:1 ends here

;; [[file:~/.emacs.d/myinit.org::*langtool][langtool:1]]
(use-package langtool
:ensure t
:bind
(("C-x 5 1" . langtool-check)
("C-x 5 2" . langtool-check-done)
("C-x 5 3" . langtool-show-message-at-point)
("C-x 5 4" . langtool-correct-buffer)))
;; langtool:1 ends here

;; [[file:~/.emacs.d/myinit.org::*yasnippet][yasnippet:1]]
(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :init (yas-global-mode 1))
;; yasnippet:1 ends here

;; [[file:~/.emacs.d/myinit.org::*LaTeX%20(auctex%20+%20reftex%20+%20ivy-bibtex%20+%20pdf-tools)][LaTeX (auctex + reftex + ivy-bibtex + pdf-tools):1]]
(use-package tex-site
;(use-package auctex
:defer t
:ensure auctex
:mode ("\\.tex\\'" . latex-mode)
:config
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(turn-on-auto-fill)
;(pdf-tools-install)
(setq TeX-engine 'xetex)
(setq TeX-show-completion t)
(add-hook 'pdf-view-mode-hook (lambda() (linum-mode -1)))
(setq TeX-save-query nil)
(eval-after-load "tex"
'(progn
(TeX-global-PDF-mode t)))

(setq TeX-view-program-selection '((output-pdf "pdf-tools"))
    TeX-view-program-list '(("pdf-tools" "TeX-pdf-tools-sync-view"))
    TeX-source-correlate-mode t
    TeX-source-correlate-start-server t)

(add-hook 'TeX-after-compilation-finished-functions
        #'TeX-revert-document-buffer)

;(global-set-key (kbd "C-c C-g") 'pdf-sync-forward-search)
;(setq mouse-wheel-follow-mouse t)
;(setq pdf-view-resize-factor 1.10)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(setq reftex-plug-into-AUCTeX t)
(reftex-isearch-minor-mode)
(setq TeX-source-correlate-method 'synctex)
(setq TeX-source-correlate-start-server t)
)
;; ivy-bibtex
(use-package ivy-bibtex
:ensure t
:bind ("<f3>" . ivy-bibtex)
:config
;(setq bibtex-completion-bibliography
;    '("../ref.bib"
;      "./ref.bib"))
(setq bibtex-completion-bibliography 
      '("./ref.bib"))

;; Customize layout of search results
;; first add journal and booktitle to the search fields
(setq bibtex-completion-additional-search-fields '(journal booktitle))
(setq bibtex-completion-display-formats
    '((article       . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:*} ${journal:40}")
      (inbook        . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:*} Chapter ${chapter:32}")
      (incollection  . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
      (inproceedings . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
      (t             . "${=has-pdf=:1}${=has-note=:1} ${=type=:3} ${year:4} ${author:36} ${title:*}")))

;; using bibtex path reference to pdf file
(setq bibtex-completion-pdf-field "File")

;;open pdf with external viwer okular
(setq bibtex-completion-pdf-open-function
      (lambda (fpath)
        (call-process "/usr/bin/okular" nil 0 nil fpath)))

(setq ivy-bibtex-default-action 'ivy-bibtex-insert-citation))

;; pdf-tools
(use-package pdf-tools
:ensure t
:mode ("\\.pdf\\'" . pdf-tools-install)
:bind ("C-c C-g" . pdf-sync-forward-search)
:defer t
:config
(setq mouse-wheel-follow-mouse t)
(setq pdf-view-resize-factor 1.10))
;; LaTeX (auctex + reftex + ivy-bibtex + pdf-tools):1 ends here

;; [[file:~/.emacs.d/myinit.org::*C/C++][C/C++:1]]
(use-package cc-mode
:defer t
:config
(use-package google-c-style
:ensure t
:init
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (google-set-c-style)
	    (google-make-newline-indent)))
:config
(c-set-offset 'statement-case-open 0)))
;; C/C++:1 ends here

;; [[file:~/.emacs.d/myinit.org::*python%20(add%20more)][python (add more):1]]
(use-package python
:mode ("\\.py\\'|wscript" . python-mode)
:interpreter ("python" . python-mode))

(use-package elpy
:ensure t
:defer t
:init
(advice-add 'python-mode :before 'elpy-enable)
:config (flycheck-mode))

(use-package py-autopep8
:ensure t
:config
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save))
;; python (add more):1 ends here

;; [[file:~/.emacs.d/myinit.org::*org-mode][org-mode:1]]
(use-package org
;:ensure org-plus-contrib
:pin org
:bind
(("C-c c" . org-capture)
 ("C-c a" . org-agenda)
 ("C-c l" . org-store-link)
 ("C-c b" . org-iswitchb))
:config
;; (use-package ox-reveal :ensure t)
(auto-fill-mode))
(setq org-startup-indented t) ;set indent
(setq org-hide-leading-stars t)
(setq org-log-done 'time)

;; org-mode for GTD
(defun gtd ()
    (interactive)
    (find-file "~/github/GTD/gtd.org"))

 (setq org-agenda-files '("~/github/GTD/inbox.org"
                          "~/github/GTD/gtd.org"
			      "~/github/GTD/tickler.org"))

 ;; C-cc to capture
 (setq org-capture-templates
    '(("t" "Todo [inbox]" entry (file+headline "~/github/GTD/inbox.org" "Tasks")
       "* TODO %i%?")
       ("T" "Tickler" entry (file+headline "~/github/GTD/tickler.org")
        "* %i%? \n %U")))
 ;; moving entry to appropriate place
 (setq org-refile-targets '(("~/github/GTD/gtd.org" :maxlevel . 3)
                            ("~/github/GTD/someday.org" :level . 1)
                            ("~/github/GTD/tickler.org" :maxlevel . 2)
			        ("~/Documents/Study/note/booknote.org" :maxlevel . 3)))

 ;; set todo keywords
 (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
 (setf org-todo-keyword-faces '(("WAITING" . (:foreground "yellow" :background "red" :bold t :weight bold))
			     ("TODO" . (:foreground "cyan" :background "steelblue" :bold t :weight bold))
			     ("DONE" . (:foreground "yellow" :background "magenta2" :bold t :weight bold))
			     ("CANCELLED" . (:foreground "gray50" :background "gray30"))))
 ;; filtering projects & actions
 (setq org-agenda-custom-commands 
       '(("o" "At the office" tags-todo "office"
          ((org-agenda-overriding-header "Office")))
	    ("h" "At home" tags-todo "home")
	    ("w" "Waiting to do" todo "WAITING" nil)
	    ("W" "Working on" tags "workingon" nil)))
 ;; 级联配置，在子TODO都完成后设置父TODO项
 (defun org-summary-todo (n-done n-not-done)
 "Switch entry to DONE when all subentries are done, to TODO otherwise."
 (let (org-log-done org-log-states)   ; turn off logging
 (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
 (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
;; org-mode:1 ends here

;; [[file:~/.emacs.d/myinit.org::*markdown][markdown:1]]
(use-package markdown-mode
:ensure t
:mode ".md"
:config
(auto-fill-mode))
;; markdown:1 ends here

;; [[file:~/.emacs.d/myinit.org::*magit][magit:1]]
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))
;; magit:1 ends here

;; [[file:~/.emacs.d/myinit.org::*dash][dash:1]]
(add-to-list 'load-path "~/.emacs.d/elpa/dash-at-point-20180710.1356/dash-at-point.el")
(autoload 'dash-at-point "dash-at-point"
          "Search the word at point with Dash." t nil)
(global-set-key "\C-cd" 'dash-at-point)
(global-set-key "\C-ce" 'dash-at-point-with-docset)
;; dash:1 ends here