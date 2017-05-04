;;; init-default.el --- Emacs configuration

;; Copyright (C) 2017 Dmytro Stechenko
;; License: http://www.gnu.org/licenses/gpl.html

;;; Commentary:
;;
;; Default packages configuration and tweaks.
;;

;;; Code:

(require 'package)
(require 'dired-x)
(require 'init-util)

(setq package-archives '(("gnu"          . "http://elpa.gnu.org/packages/")
                         ("org"          . "http://orgmode.org/elpa/")
                         ("melpa"        . "http://melpa.org/packages/")
                         ("melpa-stable" . "http://stable.melpa.org/packages/")
                         ("elpy"         . "http://jorgenschaefer.github.io/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(setq
 user-full-name "Dmytro Stechenko"
 custom-file (expand-tmp "custom.el"))

(load custom-file)

(setq
 debug-on-error nil
 debug-on-quit  nil)

(set-frame-font "PragmataPro")
(fset  'yes-or-no-p 'y-or-n-p)

(line-number-mode        1)
(column-number-mode      1)
(show-paren-mode         1)
(global-visual-line-mode 1)
(scroll-bar-mode        -1)
(menu-bar-mode          -1)
(tool-bar-mode          -1)
(mouse-wheel-mode       -1)
(electric-indent-mode   -1)
(blink-cursor-mode      -1)

(defvar tags-revert-without-query t)

(setq
 vc-follow-symlinks        t
 inhibit-startup-screen    t
 scroll-error-top-bottom   t
 tags-add-tables           nil
 initial-scratch-message   nil
 create-lockfiles          nil
 make-backup-files         nil
 tooltip-mode              nil
 show-help-function        nil
 sentence-end-double-space nil
 ring-bell-function        'ignore)

(setq-default
 fill-column                    80
 tab-width                      4
 c-basic-offset                 4
 indent-tabs-mode               nil
 cursor-in-non-selected-windows nil)

(diminish 'visual-line-mode)

(use-package ido
  :config
  (setq ido-save-directory-list-file (expand-tmp "ido.last")))

(use-package recentf
  :config
  (setq recentf-save-file (expand-tmp "recentf")))

(use-package bookmark
  :config
  (setq bookmark-default-file (expand-tmp "bookmarks")))

(use-package page-break-lines
  :diminish
  page-break-lines-mode)

(use-package flyspell
  :diminish
  flyspell-mode)

(use-package disable-mouse
  :diminish
  global-disable-mouse-mode

  :config
  (global-disable-mouse-mode))

(use-package base16-theme
  :config
  (load-theme 'base16-tomorrow-night t))

(use-package powerline
  :config
  (powerline-default-theme))

(use-package neotree
  :config
  (setq
   neo-window-width 40
   neo-theme "ascii")

  :bind
  ("H-o" . neotree-toggle))

(use-package smex
  :bind
  ("M-x" . smex)
  ("M-X" . smex-major-mode-commands)

  :config
  (setq smex-save-file (expand-tmp "smex-items")))

(use-package anzu
  :diminish
  anzu-mode

  :config
  (global-anzu-mode 1))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents  . 5)
                          (projects . 5)
                          (bookmarks . 5))))

(use-package projectile
  :diminish
  projectile-mode

  :demand
  (setq projectile-use-git-grep t)

  :commands
  projectile-project-p

  :config
  (projectile-mode 1)
  (setq
   projectile-known-projects-file (expand-tmp "projectile-bookmarks.eld")
   projectile-tags-backend 'etags-select
   projectile-switch-project-action 'neotree-projectile-action)

  :bind
  ("s-o" . projectile-find-file)
  ("s-p" . projectile-grep)
  ("M-." . projectile-find-tag)
  ("s-'" . projectile-regenerate-tags))

(use-package flx-ido
  :demand

  :commands
  ido-everywhere

  :init
  (setq
   ido-enable-flex-matching t
   ido-show-dot-for-dired nil
   ido-enable-dot-prefix t)

  :config
  (ido-mode 1)
  (ido-everywhere 1)
  (flx-ido-mode 1))

(use-package popup-imenu
  :commands
  popup-imenu

  :config
  (setq popup-imenu-style 'flat)

  :bind
  ("M-i" . popup-imenu))

(use-package magit
  :commands
  magit-status

  :config
  (magit-auto-revert-mode -1)

  :bind
  ("s-g" . magit-status))

(use-package git-timemachine
  :bind
  ("s-G" . git-timemachine-toggle))

(use-package git-gutter
  :diminish
  git-gutter-mode "Git"

  :config
  (custom-set-variables '(git-gutter:modified-sign "*")
                        '(git-gutter:added-sign    "+")
                        '(git-gutter:deleted-sign  "-"))

  :bind
  ("s-t" . git-gutter-mode)
  ("s-T" . git-gutter:revert-hunk))

(use-package company
  :diminish
  company-mode

  :commands
  company-mode

  :config
  (setq company-tooltip-align-annotations t)

  :bind
  ("C-<return>" . company-complete-common))

(use-package yasnippet
  :diminish
  yas-minor-mode

  :commands
  (yas-minor-mode yas-reload-all)

  :config
  (yas-reload-all)

  :bind
  ("C-<tab>" . yas-describe-tables))

(use-package smartparens
  :diminish
  smartparens-mode

  :commands
  sp-pair

  :config
  (require 'smartparens-config)
  (sp-use-smartparens-bindings)
  (sp-pair "(" ")" :wrap "s-(")
  (sp-pair "[" "]" :wrap "s-[")
  (sp-pair "{" "}" :wrap "s-{")

  :bind
  ("C-M-y" . sp-down-sexp))

(use-package whitespace-cleanup-mode
  :diminish
  whitespace-cleanup-mode

  :config
  (global-whitespace-cleanup-mode 1))

(use-package expand-region
  :commands
  er/expand-region

  :bind
  ("s-w" . er/expand-region))

(use-package etags-select
  :commands etags-select-find-tag)

(use-package ctags-update
  :diminish
  ctags-auto-update-mode

  :commands
  turn-on-ctags-auto-update-mode)

(use-package exec-path-from-shell
  :init
  (exec-path-from-shell-initialize))

(use-package beacon
  :diminish
  beacon-mode

  :config
  (beacon-mode 1)
  (setq
   beacon-size 15
   beacon-blink-when-focused t
   beacon-blink-when-point-moves-vertically 2
   beacon-blink-when-point-moves-horizontally 2
   beacon-color (face-attribute 'cursor :background)))

(use-package subword
  :diminish
  subword-mode)

(use-package rainbow-delimiters
  :diminish
  rainbow-delimiters-mode)

(use-package auto-package-update
  :config
  (auto-package-update-maybe))

(add-window-hook 'toggle-frame-fullscreen)
(add-text-hook   'flyspell-mode)
(add-prog-hook   'flyspell-prog-mode)
(add-prog-hook   'which-function-mode)
(add-prog-hook   'rainbow-delimiters-mode)
(add-prog-hook   'turn-on-ctags-auto-update-mode)
(add-prog-hook   'subword-mode)

(global-set-key (kbd "C-k")            'kill-whole-line)
(global-set-key (kbd "C-.")            'xref-find-definitions)
(global-set-key (kbd "C-S-k")          'kill-visual-line)
(global-set-key (kbd "M-o")            'other-window)
(global-set-key (kbd "s-i")            'ispell-word)
(global-set-key [remap dabbrev-expand] 'hippie-expand)

(provide 'init-default)

;;; init-default.el ends here