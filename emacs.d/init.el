(setq inhibit-startup-screen 't)
(setq visible-bell t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(require 'paren)
(setq show-paren-style 'parenthesis)
(show-paren-mode +1)

(electric-pair-mode +1)

(require 'color-theme-tomorrow "/Users/wfarr/.emacs.d/color-theme-tomorrow.el")

(load-theme 'tomorrow-night t)

(defalias 'yes-or-no-p 'y-or-n-p)

(require 'package)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages
  '(
    ack
    coffee-mode
    css-mode
    eldoc
    etags
    js2-mode
    json
    make-mode
    org
    markdown-mode
    puppet-mode
    ruby-mode
    ))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(ido-mode)
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

(setq explicit-shell-file-name "/opt/boxen/homebrew/bin/bash")

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
