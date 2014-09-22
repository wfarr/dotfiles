(setq inhibit-startup-screen 't)
(setq visible-bell t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(require 'paren)
(setq show-paren-style 'parenthesis)
(show-paren-mode +1)

(electric-pair-mode +1)

(setq ns-use-srgb-colorspace t)

(let ((default-directory "~/.emacs.d/"))
  (normal-top-level-add-to-load-path '("base16" "enhanced-ruby-mode" "powerline")))

;;(require 'base16-chalk-theme)

(defalias 'yes-or-no-p 'y-or-n-p)

(require 'package)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages
  '(
    ;; behavior-altering packages
    auto-complete
    flycheck
    helm
    helm-ack
    helm-projectile
    magit
    projectile

    ;;???
    eldoc
    etags
    grizzl
    highlight-indentation
    json

    ;;themes
    base16-theme
    zenburn-theme
    spacegray-theme

    ;; go-related packages
    go-mode
    go-autocomplete
    go-eldoc

    ;; misc mode packages
    coffee-mode
    css-mode
    js2-mode
    make-mode
    markdown-mode
    scss-mode
    ))

;;(setq package-pinned-packages '(:magit . "melpa"))
;;(setq package-pinned-packages '(:spacegray-theme . "melpa"))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;;(load-theme 'zenburn t)
;;(load-theme 'wombat t)
;;(load-theme 'spacegray t)
;;(global-hl-line-mode -1)
(load-theme 'base16-tomorrow t)


(setq default-frame-alist '((background-color . "#1d1f21")))
(set-background-color "#1d1f21")

(setq mac-allow-anti-aliasing 't)

(fringe-mode 0)

(setq
 backup-by-copying t
 backup-directory-alist
 '(("." . "~/.saves"))
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t
)

(require 'puppet-mode "/Users/wfarr/.emacs.d/puppet-mode.el")
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))

(defun kill-other-buffers ()
  "Kill all buffers but the current one.
Don't mess with special buffers."
  (interactive)
  (dolist (buffer (buffer-list))
    (unless (or (eql buffer (current-buffer)) (not (buffer-file-name buffer)))
      (kill-buffer buffer))))

(global-set-key (kbd "C-c k") 'kill-other-buffers)

(defun visit-term-buffer ()
  "Create or visit a terminal buffer."
  (interactive)
  (if (not (get-buffer "*ansi-term*"))
      (progn
        (split-window-sensibly (selected-window))
        (other-window 1)
        (shell))
    (switch-to-buffer-other-window "*shell*")))

(setq explicit-shell-file-name "/bin/bash")

(global-set-key (kbd "C-c t") 'visit-term-buffer)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(ansi-term-color-vector
   [unspecified "#202020" "#fb9fb1" "#acc267" "#ddb26f" "#6fc2ef" "#e1a3ee" "#6fc2ef" "#e0e0e0"])
 '(calendar-week-start-day 1)
 '(custom-safe-themes
   (quote
    ("51bea7765ddaee2aac2983fac8099ec7d62dff47b708aa3595ad29899e9e9e44" "9bac44c2b4dfbb723906b8c491ec06801feb57aa60448d047dbfdbd1a8650897" "e53cc4144192bb4e4ed10a3fa3e7442cae4c3d231df8822f6c02f1220a0d259a" "53e29ea3d0251198924328fd943d6ead860e9f47af8d22f0b764d11168455a8e" "9e7e1bd71ca102fcfc2646520bb2f25203544e7cc464a30c1cbd1385c65898f4" "146d24de1bb61ddfa64062c29b5ff57065552a7c4019bee5d869e938782dfc2a" "dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" "5ee12d8250b0952deefc88814cf0672327d7ee70b16344372db9460e9a0e3ffc" "cf08ae4c26cacce2eebff39d129ea0a21c9d7bf70ea9b945588c1c66392578d1" "1157a4055504672be1df1232bed784ba575c60ab44d8e6c7b3800ae76b42f8bd" default)))
 '(fci-rule-color "#343d46")
 '(flycheck-highlighting-mode (quote lines))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#bf616a")
     (40 . "#DCA432")
     (60 . "#ebcb8b")
     (80 . "#B4EB89")
     (100 . "#89EBCA")
     (120 . "#89AAEB")
     (140 . "#C189EB")
     (160 . "#bf616a")
     (180 . "#DCA432")
     (200 . "#ebcb8b")
     (220 . "#B4EB89")
     (240 . "#89EBCA")
     (260 . "#89AAEB")
     (280 . "#C189EB")
     (300 . "#bf616a")
     (320 . "#DCA432")
     (340 . "#ebcb8b")
     (360 . "#B4EB89"))))
 '(vc-annotate-very-old-color nil)
 '(whitespace-style
   (quote
    (face trailing lines-tail newline empty newline-mark indentation tab-mark space-mark))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq-default indent-tabs-mode nil
              tab-width 4)

(setq-default c-basic-offset 4
              c-default-style "linux")

(projectile-global-mode)
(setq projectile-enable-caching nil)


(setq exec-path
	  (append
	   (list
		 (format "%s/bin" (getenv "HOME"))
		 (format "%s/go/bin" (getenv "HOME"))
		 "/usr/local/bin"
		 )
	   exec-path
	   ))

(setenv "PATH"
        (concat
         (mapconcat
          (lambda (s) s)
          exec-path
          ":")))

(setenv "GOPATH" (getenv "HOME"))

(if (executable-find "go")
	(progn
      (unless (file-directory-p (concat (getenv "GOPATH") "/src/code.google.com/p/go.tools/cmd/vet"))
        (shell-command "go get -u code.google.com/p/go.tools/cmd/vet"))
      (unless (file-directory-p (concat (getenv "GOPATH") "/src/code.google.com/p/go.tools/godoc"))
        (shell-command "go get -u code.google.com/p/go.tools/godoc"))
      (unless (executable-find "golint")
        (shell-command "go get -u code.google.com/p/go.tools/cmd/golint"))
	  (unless (executable-find "godef")
		(shell-command "go get -u code.google.com/p/rog-go/exp/cmd/godef"))
	  (unless (executable-find "oracle")
		(shell-command "go get code.google.com/p/go.tools/cmd/oracle"))
	  (unless (executable-find "gocode")
		(shell-command "go get -u github.com/nsf/gocode"))))

(load-file "$GOPATH/src/code.google.com/p/go.tools/cmd/oracle/oracle.el")

(add-hook 'go-mode-hook
          (lambda ()
			(require 'flycheck)
			(flycheck-mode)

			(setq-default indent-tabs-mode 't)

			(go-eldoc-setup)
			(go-oracle-mode)

			(if (not (string-match "go" compile-command))
				(set (make-local-variable 'compile-command)
					 "go build -v && go vet &&  go test -v -coverprofile c.out && go tool cover -func c.out"))

			(local-set-key (kbd "M-.") 'godef-jump)
			(local-set-key (kbd "C-c C-c C-c") 'compile)

			(setq-local compilation-read-command nil)

			(add-hook 'before-save-hook 'gofmt-before-save)
			))


(add-to-list 'load-path "enhanced-ruby-mode") ; must be added after any path containing old ruby-mode
(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\(Gemfile\\|Puppetfile\\|\\.rb\\)$" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
(setq enh-ruby-program "/usr/bin/ruby") ; so that still works if ruby points to ruby1.8
(setq ruby-program "/usr/bin/ruby")
(setq enh-ruby-deep-indent-paren nil)

(setq projectile-enable-caching t)
(setq projectile-completion-system 'grizzl)

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (eldoc-mode)))

(require 'go-mode)
(require 'auto-complete-config)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-1.4/dict")
(ac-config-default)

(require 'go-autocomplete)

;;(setq ac-delay nil)
(setq ac-ignore-case nil)
(setq ac-use-fuzzy 't)
(setq ac-use-quick-help 't)

(add-to-list 'ac-modes 'go-mode)
(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'web-mode)

(add-hook 'before-save-hook
          (lambda ()
            (when buffer-file-name
              (let ((dir (file-name-directory buffer-file-name)))
                (when (and (not (file-exists-p dir))
                           (y-or-n-p (format "Directory %s does not exist. Create it?" dir)))
                  (make-directory dir t))))))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

(require 'helm-config)
(helm-mode 1)

(setq helm-buffers-fuzzy-matching 't)

(require 'helm-projectile)

;; (require 'evil)
;; (evil-mode)

;; requires https://github.com/railwaycat/emacs-mac-port
(defun mac-switch-meta nil
  "switch meta between Option and Command"
  (interactive)
  (if (eq mac-option-modifier nil)
      (progn
        (setq mac-option-modifier 'meta)
        (setq mac-command-modifier 'hyper))
    (progn
      (setq mac-option-modifier nil)
      (setq mac-command-modifier 'meta))))


(defun mac-global-set-key-with-modifier (key command)
  "Bind a key, but do auto-translation of super/hyper as appropriate"
  (if (boundp 'mac-mouse-wheel-mode)
      (global-set-key (kbd (concat "H-" key)) command)
    (global-set-key (kbd (concat "s-" key)) command)))

(if (boundp 'mac-mouse-wheel-mode)
    (progn
      (mac-switch-meta)
      (mac-mouse-wheel-mode)))

(mac-global-set-key-with-modifier "a" 'mark-whole-buffer)
(mac-global-set-key-with-modifier "v" 'yank)
(mac-global-set-key-with-modifier "c" 'kill-ring-save)
(mac-global-set-key-with-modifier "s" 'save-buffer)
(mac-global-set-key-with-modifier "l" 'goto-line)
(mac-global-set-key-with-modifier "w" (lambda () (interactive) (delete-window)))
(mac-global-set-key-with-modifier "z" 'undo)
(mac-global-set-key-with-modifier "t" 'helm-projectile)
(mac-global-set-key-with-modifier "b" 'helm-buffer-list)
(mac-global-set-key-with-modifier "g" 'magit-status)
