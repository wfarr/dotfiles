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
             '("org" . "http://orgmode.org/elpa/") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages
  '(
    ack
    auto-complete
    coffee-mode
    css-mode
    diminish
    eldoc
    etags
    find-file-in-project
    find-file-in-repository
    go-mode
    grizzl
    highlight-indentation
    ido-ubiquitous
    js2-mode
    json
    make-mode
    org-plus-contrib
    markdown-mode
    zenburn-theme
    projectile
    ))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;;(load-theme 'zenburn t)
(load-theme 'wombat t)


(require 'ido)
(require 'ido-ubiquitous)
(ido-mode)
(ido-ubiquitous-mode 1)
(setq ido-enable-flex-matching t)

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
 '(custom-safe-themes (quote ("cf08ae4c26cacce2eebff39d129ea0a21c9d7bf70ea9b945588c1c66392578d1" "1157a4055504672be1df1232bed784ba575c60ab44d8e6c7b3800ae76b42f8bd" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;(setq default-frame-alist '((background-color . "#27292C")))
;;(set-background-color "#27292C")

(setq mac-allow-anti-aliasing 't)

(setq-default indent-tabs-mode nil
              tab-width 4)

(setq-default c-basic-offset 4
              c-default-style "linux")

(projectile-global-mode)

(custom-set-variables
 '(whitespace-style '(face trailing lines-tail newline empty newline-mark indentation tab-mark space-mark))
 '(whitespace-space-regexp "\\(^ +\\| +$\\)")
 '(calendar-week-start-day 1)
 '(org-agenda-files (quote ("/Users/wfarr/Dropbox/org/gtd.org")))
 '(org-agenda-ndays 7)
 '(org-agenda-repeating-timestamp-show-all nil)
 '(org-agenda-restore-windows-after-quit t)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-sorting-strategy (quote ((agenda time-up priority-down tag-up) (todo tag-up))))
 '(org-agenda-start-on-weekday nil)
 '(org-agenda-todo-ignore-deadlines t)
 '(org-agenda-todo-ignore-scheduled t)
 '(org-agenda-todo-ignore-with-date t)
 '(org-agenda-window-setup (quote other-window))
 '(org-deadline-warning-days 7)
 '(org-fast-tag-selection-single-key nil)
 '(org-log-done (quote (done)))
 '(org-refile-targets (quote (("gtd.org" :maxlevel . 1) ("someday.org" :level . 2))))
 '(org-reverse-note-order nil)
 '(org-tags-column -78)
 '(org-tags-match-list-sublevels nil)
 '(org-time-stamp-rounding-minutes 5)
 '(org-use-fast-todo-selection t)
 '(org-use-tag-inheritance nil)
)

(add-hook 'go-mode-hook
          (lambda ()
            (setq-default indent-tabs-mode 't)))


(add-to-list 'load-path "enhanced-ruby-mode") ; must be added after any path containing old ruby-mode
(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\(Gemfile\\|Puppetfile\\|\\.rb\\)$" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
(setq enh-ruby-program "/usr/bin/ruby") ; so that still works if ruby points to ruby1.8
(setq ruby-program "/usr/bin/ruby")

(setq projectile-enable-caching t)
(setq projectile-completion-system 'grizzl)

(global-set-key (kbd "s-t") 'projectile-find-file)
(global-set-key (kbd "s-b") 'projectile-switch-to-buffer)

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (eldoc-mode)))

(require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories
;;     "~/.emacs.d/.cask/24.3.50.1/elpa/auto-complete-20130724.1750/dict")
(ac-config-default)

(setq ac-ignore-case nil)
(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'web-mode)

(require 'highlight-indentation)
(add-hook 'enh-ruby-mode-hook
          (lambda () (highlight-indentation-current-column-mode)))

(add-hook 'coffee-mode-hook
          (lambda () (highlight-indentation-current-column-mode)))

(require 'powerline)
(powerline-default-theme)

(require 'org)
(require 'remember)
(require 'org-remember)
(add-hook 'org-mode-hook
          (lambda ()
            (progn
              (require 'org-mac-link)
              (setq org-use-fast-todo-selection t)
              (setq org-use-fast-tag-selection t)
              (setq org-log-done nil)
              (setq org-agenda-include-diary nil)
              (setq org-deadline-warning-days 7)
              (setq org-timeline-show-empty-dates t)
              (setq org-insert-mode-line-in-empty-file t)

              (define-key org-mode-map (kbd "C-c g") 'org-mac-grab-link))))

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)


(setq org-directory "/Users/wfarr/Dropbox/org/")
(setq org-default-notes-file "~/.notes")

(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)
(define-key global-map "\C-cr" 'org-remember)

(setq org-remember-templates
      '(
        ("Todo" ?t "* TODO %^{Brief Description} %^g\n%?\nAdded: %U" "/Users/wfarr/Dropbox/org/gtd.org" "Tasks")
        ))

(setq org-agenda-custom-commands
'(

  ("P" "Projects"
   ((tags "PROJECT")))

  ("H" "Office and Home Lists"
   ((agenda)
    (tags-todo "OFFICE")
    (tags-todo "HOME")
    (tags-todo "COMPUTER")
    (tags-todo "DVD")
    (tags-todo "READING")))

  ("D" "Daily Action List"
   ((agenda "" ((org-agenda-ndays 1)
                (org-agenda-sorting-strategy
                 (quote ((agenda time-up priority-down tag-up))))
                (org-deadline-warning-days 0)))))))

(defun gtd ()
  (interactive)
  (find-file "/Users/wfarr/Dropbox/org/gtd.org"))

(global-set-key (kbd "C-c g") 'gtd)
