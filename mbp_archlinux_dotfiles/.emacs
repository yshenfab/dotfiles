(add-to-list 'load-path "~/.emacs.d/elpa/yshen")
;;===============================================
;;Part 1: Basic config
;;===============================================
;; set default fonts, Inconsolata for English, KatTi for Chinese
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :family "Inconsolata")))))

;; (set-default-font "-unknown-Inconsolata-normal-normal-normal-*-20-*-*-*-m-0-iso10646-1")
;; (dolist (charset '(kana han symbol cjk-misc bopomofo))
;; (set-fontset-font (frame-parameter nil 'font)
;;                  charset (font-spec :family "KaiTi_GB2312"
;;                                     :size 19)))

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

;;===============================================
;;Part 2: My own keybindings
;;===============================================
;;F1: speedbar, C-F1: help
(global-set-key [(f1)] 'speedbar-get-focus)
(global-set-key [C-f1] 'info)
;;F2: speedbar hotkey, C-F2: activate ecb
(global-set-key [f2] 'ecb-activate)
(global-set-key [C-f2] 'ecb-deactivate)
;;F3: show/hide toolbar, C-F3: show/hide menu
(global-set-key [f3] 'tool-bar-mode)
(global-set-key [C-f3] 'menu-bar-mode)
;;F4: gdb
(global-set-key [f4] 'gdb)
;;F5: compile (make)
(defun du-onekey-compile ()
  "Save buffers and start compile"
  (interactive)
  (save-some-buffers t)
  (switch-to-buffer-other-window "*compilation*")
  (compile compile-command))

(setq-default compile-command "make")    
(global-set-key [C-f5] 'compile)
 (global-set-key [f5] 'du-onekey-compile)
;;F6: start a new buffer and open shell, C-F6: open shell in current buffer, Shift+F6: clear eshell
(defun open-eshell-other-buffer ()
  "Open eshell in other buffer"
  (interactive)
  (split-window-vertically)
  (eshell))
(defun my-eshell-clear-buffer ()
  "Eshell clear buffer."
  (interactive)
  (let ((eshell-buffer-maximum-lines 0))
    (eshell-truncate-buffer)))
(global-set-key [(f6)] 'open-eshell-other-buffer)
(global-set-key [C-f6] 'eshell)
(global-set-key [S-f6] 'my-eshell-clear-buffer)
;;F7: calendar
(global-set-key [f7] 'calendar)
;;F8: go to definition of function, Shift-F9: jump back
(global-set-key [f8] 'semantic-ia-fast-jump)
(global-set-key [S-f8]
	(lambda ()
	(interactive)
	(if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
	(error "Semantic Bookmark ring is currently empty"))
	(let* ((ring (oref semantic-mru-bookmark-ring ring))
	(alist (semantic-mrub-ring-to-assoc-list ring))
	(first (cdr (car alist))))
	(if (semantic-equivalent-tag-p (oref first tag)
	(semantic-current-tag))
	(setq frist (cdr (car (cdr alist)))))
	(semantic-mrub-switch-tags first))))
;;F9: hide ecb windows, Shift-F9: show ecb windows
(global-set-key [f9] 'ecb-hide-ecb-windows)
(global-set-key [S-f9] 'ecb-show-ecb-windows)

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

;;===============================================
;;Part 3: Plugins
;;===============================================
;;package
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
			 ;; ("org" . "https://orgmode.org/elpa/")))
;; (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;; (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(setq package-enable-at-startup nil)
(package-initialize)
(setq url-http-attempt-keepalives nil)

(when (not package-archive-contents)
    (package-refresh-contents))

;;yasnippet
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;;color-theme
;; (add-to-list 'load-path "/home/yang/.emacs.d/elpa/color-theme-6.6.0")
;; (load "/home/yang/.emacs.d/elpa/color-theme-6.6.0/color-theme-monokai.el")
;; (color-theme-monokai)
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/monokai-theme-20180104.429")
(load-theme 'monokai t)

;;auto-complete
(add-to-list 'load-path "/home/yang/.emacs.d/elpa/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/yang/.emacs.d/elpa/auto-complete/dict")
(ac-config-default)
;;(delq 'ac-source-yasnippet ac-sources)
(setq ac-fuzzy-enable t)
(global-auto-complete-mode t)

;;ido
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;;smex
(require 'smex)
;; (smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;org-mode
;; (add-to-list 'load-path "~/Downloads/org-9.0.9/lisp")

;; (add-to-list 'load-path "~/.emacs.d/elpa/org-9.0.9-contrib/lisp" t)
;; (require 'htmlize)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-startup-indented t) ;set indent
(setq org-hide-leading-stars t)
(setq org-log-done 'time)
;; org-mode for GTD
(defun gtd ()
   (interactive)
   (find-file "~/todo/gtd/gtd.org")
)

(setq org-agenda-files '("~/todo/gtd/inbox.org"
                         "~/todo/gtd/gtd.org"
			 "~/todo/gtd/tickler.org"))

;; C-cc to capture
(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/todo/gtd/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/todo/gtd/tickler.org" "Tickler")
                               "* %i%? \n %U")))
;; moving entry to appropriate place
(setq org-refile-targets '(("~/todo/gtd/gtd.org" :maxlevel . 3)
                           ("~/todo/gtd/tolearn.org" :level . 1)
                           ("~/todo/gtd/tickler.org" :maxlevel . 2)
			   ("~/Documents/Study/note/booknote.org" :maxlevel . 3)
			   ))

;; set todo keywords
(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
(setf org-todo-keyword-faces '(("WAITING" . (:foreground "yellow" :background "red" :bold t :weight bold))
			       ("TODO" . (:foreground "cyan" :background "steelblue" :bold t :weight bold))
			       ("DONE" . (:foreground "yellow" :background "magenta2" :bold t :weight bold))
			       ("CANCELLED" . (:foreground "gray50" :background "gray30"))))

;; filtering projects & actions
(setq org-agenda-custom-commands 
      '(
	("o" "At the office" tags-todo "office"
         ((org-agenda-overriding-header "Office")))
	("h" "At home" tags-todo "home")
	("w" "Waiting to do" todo "WAITING" nil)
	("W" "Working on" tags "workingon" nil)
	)
)
;; 级联配置，在子TODO都完成后设置父TODO项
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
;;===============================================
;;Part 4: C/C++ development
;;===============================================
;;indent
(setq c-default-style "linux" c-basic-offset 4)
;;hide/show
(add-hook 'c-mode-common-hook
  (lambda()
    (local-set-key (kbd "C-c <right>") 'hs-show-block)
    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
    (local-set-key (kbd "C-c <down>")  'hs-show-all)
    (hs-minor-mode t)))

(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))

;;===================
;;gdb-UI config
;;===================
(setq gdb-many-windows t)
(load-library "multi-gud.el")
(load-library "multi-gdb-ui.el")

;;===================
;;cedet config
;;===================
(semantic-mode 1)
(global-ede-mode t)
(global-semantic-idle-scheduler-mode t)
;; (semantic-load-enable-code-helpers)
;; (global-srecode-minor-mode 1)

;;fold all code in the whole buffer
;; (define-key semantic-tag-folding-mode-map (kbd "C--") 'semantic-tag-folding-fold-all)
;; (define-key semantic-tag-folding-mode-map (kbd "C-=") 'semantic-tag-folding-show-all)
;;fold code in a single buffer
;; (define-key semantic-tag-folding-mode-map (kbd "C-_") 'semantic-tag-folding-fold-block)
;; (define-key semantic-tag-folding-mode-map (kbd "C-+") 'semantic-tag-folding-show-block)

;;===================
;;ecb
;;===================
(add-to-list 'load-path "~/.emacs.d/elpa/ecb-master")
(require 'ecb)
(setq stack-trace-on-error t)
(setq ecb-layout-name "leftright1")
(setq ecb-show-sources-in-directories-buffer 'always)
(setq ecb-compile-window-height 8)
(setq ecb-tip-of-the-day nil)

;;semantic search range config
(setq semanticdb-project-roots (list (expand-file-name "/")))

;;===============================================
;;Part 5: LaTeX
;;===============================================
(add-hook 'latex-mode-hook (lambda () (auto-complete-mode t)))

(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda ()
                       (if (not (minibufferp (current-buffer)))
			   (auto-complete-mode 1))
                       ))
(real-global-auto-complete-mode t)

;;===================
;;auctex
;;===================
(add-to-list 'load-path "~/.emacs.d/elpa/auctex")
(load "auctex.el" nil t t)
(load "preview.el" nil t t)
;;customary customization
(setq Tex-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode) ;;or auto-fill-mode
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(add-hook 'LaTeX-mode-hook
	  (lambda ()
	    (setq ;TeX-auto-untabify t ; remove all tabs before saving
	          ;Tex-command-default "xelatex"
		  TeX-engine 'xetex ; use xelatex default
		  TeX-show-compilation t) ; display compilation windows
	    (setq TeX-save-query nil)
	    (imenu-add-menubar-index)))

(eval-after-load "tex"
  '(progn
     (TeX-global-PDF-mode t)))


(setq reftex-revisit-to-follow t
      reftex-auto-recenter-toc t)
;; (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; (setq reftex-plug-into-AUCTeX t)
(add-hook 'TeX-mode-hook
          (lambda ()
            (setq reftex-plug-into-AUCTeX t)
            (turn-on-reftex)
            ))

;;===============================================
;;Part 6:html,js
;;===============================================
(require 'multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags 
  '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
    (js-mode  "<script[^>]*>" "</script>")
    (css-mode "<style[^>]*>" "</style>")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1)
;;===============================================
;;Others
;;===============================================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-layout-window-sizes
   (quote
    (("leftright1"
      (ecb-directories-buffer-name 0.1791044776119403 . 0.32)
      (ecb-sources-buffer-name 0.1791044776119403 . 0.28)
      (ecb-history-buffer-name 0.1791044776119403 . 0.36)
      (ecb-methods-buffer-name 0.1791044776119403 . 0.96)))))
 '(ecb-options-version "2.40")
 '(package-selected-packages
   (quote
    (elpy company-ycmd flycheck-ycmd find-file-in-project ace-jump-mode yasnippet color-theme-library matlab-mode markdown-preview-mode markdown-mode flycheck lua-mode monokai-theme ein py-autopep8 org-plus-contrib org web-mode w3m smex org2blog multi-web-mode htmlize auto-complete-auctex auctex)))
 '(safe-local-variable-values
   (quote
    ((TeX-trailer-start . "% Start-Of-Trailer$")
     (TeX-header-end . "% End-Of-Header$")
     (TeX-master . test\.tex)))))


;; fix emacs 25 python3 bug
(with-eval-after-load 'python
  (defun python-shell-completion-native-try ()
    "Return non-nil if can trigger native completion."
    (let ((python-shell-completion-native-enable t)
          (python-shell-completion-native-output-timeout
           python-shell-completion-native-try-output-timeout))
      (python-shell-completion-native-get-completions
       (get-buffer-process (current-buffer))
       nil "_"))))


;; org2blog & wordpress
(setq load-path (cons "~/.emacs.d/elpa/htmlize/" load-path))
(require 'htmlize)

(setq load-path (cons "~/.emacs.d/elpa/metaweblog/" load-path))
(require 'metaweblog)
(setq load-path (cons "~/.emacs.d/elpa/xml-rpc/" load-path))
(require 'xml-rpc)

(setq org-directory "~/jlinno/ROV/blog/")
(setq load-path (cons "~/.emacs.d/elpa/org2blog/" load-path))
(require 'org2blog-autoloads)
(require 'org2blog)

(setq org2blog/wp-blog-alist
      '(("jlinno"
         :url "http://jlinno.com/xmlrpc.php"
         :username "username"
         :password "password"
         :keep-new-lines t
         :confirm t
	 ;; :wp-latex t
	 ;; :wp-code t
	 ;; :track-posts t
	 :default-categories ("Tech")
         :tags-as-categories nil)
        ))

;; (setq org2blog/wp-use-sourcecode-shortcode 't)
(setq org2blog/wp-use-sourcecode-shortcode nil)
(setq org2blog/wp-use-wp-latex 't)
(setq org2blog/wp-sourcecode-default-params nil)
(setq org2blog/wp-sourcecode-langs
'("actionscript3" "bash" "coldfusion" "cpp" "csharp" "c" "css" "delphi"
  "erlang" "fsharp" "diff" "groovy" "javascript" "java" "javafx" "matlab"
  "objc" "perl" "php" "text" "powershell" "python" "ruby" "scala" "sql"
  "vb" "xml" "sh" "emacs-lisp" "lisp" "lua"))
(setq org-src-fontify-natively t)

;; (setq org2blog/wp-buffer-template
;; "#+DATE: %s
;; #+OPTIONS: toc:nil num:nil todo:nil pri:nil tags:nil ^:nil TeX:nil
;; #+CATEGORY: Tech
;; #+TAGS:
;; #+PERMALINK:
;; #+TITLE:
;; \n")

;; (defun my-format-function (format-string)
;;   (format format-string
;;           ;; org2blog/wp-default-title
;;           (format-time-string "%d-%m-%Y" (current-time))))
;; (setq org2blog/wp-buffer-format-function 'my-format-function)

(provide 'init-life-internet-org2blog)

;;========================================
;; Python config
;;========================================
;;py-autopep8
(defvar myPackages
  '(better-defaults
    ein ;;add the ein package (Emacs ipython notebook)
    elpy
    flycheck
    material-theme
    py-autopep8)) ;; add the autopep8 package
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)

;;IPython/Jupyter
(elpy-enable)
;; (elpy-use-ipython)

;; ycmd, flycheck, company, etc.
;; To use ycmd-mode in all supported modes
(require 'ycmd)
(add-hook 'after-init-hook #'global-ycmd-mode)
;; Specify only support c/c++ mode
;; (add-hook 'c++-mode-hook 'ycmd-mode)
;; (add-hook 'c++-mode-hook 'company-mode)
;; Specify how to run the server
(set-variable 'ycmd-server-command '("/usr/bin/python" "/home/yang/ycmd/ycmd/"))
;; Specify a global emacs config
(set-variable 'ycmd-global-config "/home/yang/ycmd/examples/.ycm_extra_conf.py")
;; (set-variable 'ycmd-extra-conf-whitelist '("/home/yang/todo/*"))
;; Completion framework
(require 'company-ycmd)
(company-ycmd-setup)
(add-hook 'after-init-hook #'global-company-mode)
;; Enable flycheck
(require 'flycheck-ycmd)
(flycheck-ycmd-setup)
(add-hook 'after-init-hook #'global-flycheck-mode)
;; Set always complete immediately
(setq company-idle-delay 0)

;; ace-jump-mode
(add-to-list 'load-path "~/.emacs.d/elpa/ace-jump-mode/ace-jump-mode.el")
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; enable a more powerful jump back function from ace jump mode
;;
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)
