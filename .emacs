(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(setq inhibit-startup-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(setq backup-directory-alist '(("." . "~/.emacs_saves")))
(require 'ido)
(ido-mode t)
(global-set-key (kbd "M-x") 'smex)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq scroll-margin 5)
(setq scroll-conservatively 10000)
(setq scroll-step 1)
(setq scroll-preserve-screen-position t)

;------------------------------------------------------------------------------------------
                                        ; c/c++

; requires: clangd


(use-package eglot
  :ensure t
  :hook ((c-mode . eglot-ensure)
         (c++-mode . eglot-ensure)))

(use-package company
  :ensure t
  :hook (after-init . global-company-mode))

(use-package modern-cpp-font-lock
  :ensure t
  :hook (c++-mode . modern-c++-font-lock-mode))

(setq-default c-basic-offset 4)
(setq c-default-style "linux")

(setq-default indent-tabs-mode nil)

(show-paren-mode 1)

(global-display-line-numbers-mode)

(electric-pair-mode 1)

;------------------------------------------------------------------------------------------
                                        ; ocaml

; requires: opam install merlin utop ocp-indent dune ocaml-lsp-server

(require 'ert)

(use-package tuareg
  :ensure t
  :mode ("\\.ml[iylp]?\\'" . tuareg-mode)
  :config
  (setq tuareg-indent-align-with-first-arg t))

(use-package merlin
  :ensure t
  :hook ((tuareg-mode caml-mode) . merlin-mode)
  :config
  (setq merlin-command 'opam)
  (setq merlin-completion-with-doc t))

(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0.1)
  (setq company-minimum-prefix-length 1)
  (add-to-list 'company-backends 'merlin-company-backend))

(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook (tuareg-mode . lsp)
  :config
  (setq lsp-prefer-flymake nil)
  (setq lsp-ocaml-lsp-server-command '("opam" "exec" "--" "ocamllsp")))

(use-package dune
  :ensure t)

(use-package utop
  :ensure t
  :hook (tuareg-mode . utop-minor-mode))

;------------------------------------------------------------------------------------------
                                        ; erlang


(setq load-path (cons "/usr/lib/erlang/lib/tools-3.6/emacs"
                      load-path))
(setq erlang-root-dir "/usr/lib/erlang")
(setq exec-path (cons "/usr/lib/erlang/bin" exec-path))
(require 'erlang-start)

(use-package lsp-mode
  :ensure t
  :commands lsp lsp-deferred
  :hook (erlang-mode . lsp-deferred)
  :config
  (setq lsp-erlang-server-path "/usr/local/bin/erlang_ls"))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package company
  :ensure t
  :hook (after-init . global-company-mode))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))


;------------------------------------------------------------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(erlang poetry yasnippet projectile flycheck lsp-ui utop dune lsp-mode merlin tuareg modern-cpp-font-lock company smex)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
