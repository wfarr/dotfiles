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
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

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
    ido-vertical-mode
    ido-ubiquitous
    js2-mode
    json
    magit
    make-mode
    org-plus-contrib
    markdown-mode
    zenburn-theme
    projectile
    scss-mode
    ))

(require 'linum)
(setq linum-format 'dynamic)
(global-linum-mode t)

;;(setq package-pinned-packages '(:magit . "melpa"))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;;(load-theme 'zenburn t)
(load-theme 'wombat t)


(require 'ido)
(require 'ido-ubiquitous)
(ido-mode)
(ido-vertical-mode 1)
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
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(calendar-week-start-day 1)
 '(custom-safe-themes
   (quote
    ("dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" "5ee12d8250b0952deefc88814cf0672327d7ee70b16344372db9460e9a0e3ffc" "cf08ae4c26cacce2eebff39d129ea0a21c9d7bf70ea9b945588c1c66392578d1" "1157a4055504672be1df1232bed784ba575c60ab44d8e6c7b3800ae76b42f8bd" default)))
 '(ido-vertical-mode t)
 '(org-agenda-files (quote ("/Users/wfarr/Dropbox/org/gtd.org")))
 '(org-agenda-ndays 7)
 '(org-agenda-repeating-timestamp-show-all nil)
 '(org-agenda-restore-windows-after-quit t)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-sorting-strategy
   (quote
    ((agenda time-up priority-down tag-up)
     (todo tag-up))))
 '(org-agenda-start-on-weekday nil)
 '(org-agenda-todo-ignore-deadlines t)
 '(org-agenda-todo-ignore-scheduled t)
 '(org-agenda-todo-ignore-with-date t)
 '(org-agenda-window-setup (quote other-window))
 '(org-deadline-warning-days 7)
 '(org-fast-tag-selection-single-key nil)
 '(org-log-done (quote (done)))
 '(org-refile-targets
   (quote
    (("gtd.org" :maxlevel . 1)
     ("someday.org" :level . 2))))
 '(org-reverse-note-order nil)
 '(org-tags-column -78)
 '(org-tags-match-list-sublevels nil)
 '(org-time-stamp-rounding-minutes 5)
 '(org-use-fast-todo-selection t)
 '(org-use-tag-inheritance nil)
 '(whitespace-space-regexp "\\(^ +\\| +$\\)")
 '(whitespace-style
   (quote
    (face trailing lines-tail newline empty newline-mark indentation tab-mark space-mark))))
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



(add-hook 'go-mode-hook
          (lambda ()
            (setq-default indent-tabs-mode 't)))


(add-to-list 'load-path "enhanced-ruby-mode") ; must be added after any path containing old ruby-mode
(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\(Gemfile\\|Puppetfile\\|\\.rb\\)$" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
(setq enh-ruby-program "/usr/bin/ruby") ; so that still works if ruby points to ruby1.8
(setq ruby-program "/usr/bin/ruby")
(setq enh-ruby-deep-indent-paren nil)

(setq projectile-enable-caching t)
(setq projectile-completion-system 'grizzl)

(global-set-key (kbd "s-t") 'projectile-find-file)
(global-set-key (kbd "s-b") 'projectile-switch-to-buffer)

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (eldoc-mode)))

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-1.4/dict")
(ac-config-default)

(setq ac-ignore-case nil)
(setq ac-use-quick-help nil)
(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'web-mode)

(require 'powerline)
(powerline-default-theme)

(setq rsense-home "/opt/boxen/homebrew/Cellar/rsense/0.3/libexec")
(add-to-list 'load-path (concat rsense-home "/etc"))
(require 'rsense)

(add-hook 'enh-ruby-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-rsense-method)
            (add-to-list 'ac-sources 'ac-source-rsense-constant)))

(require 'org)
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
(setq org-default-notes-file (concat org-directory "notes.org"))

(setq org-capture-templates
      '(("g" "GitHub Task" entry (file+olp (concat org-directory "gtd.org") "TASKS" "GitHub")
         "* TODO %^{Brief Description} %^g\n%?\nAdded: %U" :clock-resume :kill-buffer :empty-lines 1)
        ("t" "Todo" entry (file+headline (concat org-directory "gtd.org") "TASKS")
         "* TODO %^{Brief Description} %^g\n%?\nAdded: %U" :clock-resume :kill-buffer :empty-lines 1 :prepend)))


(define-key global-map "\C-cr" 'org-capture)

(setq org-agenda-custom-commands
'(

  ("P" "Projects"
   ((tags "PROJECT")))

  ("H" "Office and Home Lists"
   ((agenda)
    (tags-todo "OFFICE")
    (tags-todo "HOME")
    (tags-todo "COMPUTER")
    (tags-todo "TALKS")
    (tags-todo "READING")))

  ("D" "Daily Action List"
   ((agenda "" ((org-agenda-ndays 1)
                (org-agenda-sorting-strategy
                 (quote ((agenda time-up priority-down tag-up))))
                (org-deadline-warning-days 0)))))))

(defun wfarr-org-archive-done ()
  (interactive)
  (org-map-entries 'org-archive-subtree "/DONE" 'file))

(defun gtd ()
  (interactive)
  (find-file "/Users/wfarr/Dropbox/org/gtd.org"))

(global-set-key (kbd "C-c g") 'gtd)

(add-hook 'before-save-hook
          (lambda ()
            (when buffer-file-name
              (let ((dir (file-name-directory buffer-file-name)))
                (when (and (not (file-exists-p dir))
                           (y-or-n-p (format "Directory %s does not exist. Create it?" dir)))
                  (make-directory dir t))))))
