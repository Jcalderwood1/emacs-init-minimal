;;; init.el --- Initialization code ;;; -*- lexical-binding: t;-*-
;;; Commentary:

;;; Code:

(toggle-frame-fullscreen)

(eval-and-compile
  (customize-set-variable
   'package-archives '(("org"   . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu"   . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package)))

(eval-when-compile
  (require 'use-package))

;;; Emacs settings

(tool-bar-mode -1)
(show-paren-mode 1)
(global-display-line-numbers-mode 1)
(global-visual-line-mode 1)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;; font
(add-to-list 'default-frame-alist '(font . "Source Code Pro-20" ))
(set-face-attribute 'default t :font "Source Code Pro-20")

;; Stop customize from writing to this file
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

;;; Packages

(use-package magit
  :ensure t
  :pin    melpa
  :bind   (("C-x g" . magit-status)
           ("C-c g" . magit-file-dispatch)))

(use-package deadgrep
  :ensure t
  :pin    melpa
  :bind   ("<f5>" . deadgrep))

(use-package company
  :ensure t
  :pin    melpa
  :config (global-company-mode))

(use-package paredit
  :ensure t
  :pin    melpa
  :hook   ((cider-repl-mode clojure-mode emacs-lisp-mode) . paredit-mode))

(use-package cider
  :ensure t
  :pin    melpa
  :defer  t
  :custom (cider-repl-display-help-banner nil)
          (cider-font-lock-dynamically '(macro core function var))
          (cider-overlays-use-font-lock t)
	  (cider-repl-pop-to-buffer-on-connect 'display-only)
	  (cider-show-error-buffer nil)
  :bind   (("<C-return>" . cider-eval-last-sexp)
	   ("<M-return>" . cider-insert-last-sexp-in-repl)))

(use-package exec-path-from-shell
  :ensure t
  :pin    melpa
  :if     (eq system-type 'darwin)
  :config (exec-path-from-shell-initialize))

(use-package rainbow-delimiters
  :ensure t
  :pin    melpa
  :hook   ((cider-repl-mode prog-mode) . rainbow-delimiters-mode))

(use-package solarized-theme
  :ensure t
  :pin    melpa
  :config (load-theme 'solarized-dark-high-contrast t))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)
          
(provide 'init)

;;; init.el ends here
