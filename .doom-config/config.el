;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Federico Caprari"
      user-mail-address "korsmakolnikov@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dark+)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; This display fill column indicator do not work!
(setq-default display-fill-column-indicator-column 79)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
(add-hook 'markdown-mode-hook #'display-fill-column-indicator-mode)
(add-hook 'org-mode-hook #'display-fill-column-indicator-mode)
;; (add-hook 'evil-insert-state-entry-hook 'display-fill-column-indicator-mode)
;; (add-hook 'evil-normal-state-entry-hook 'display-fill-column-indicator-mode nil)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; Neotree
;;(setq neo-autorefresh nil)
;;(setq neo-window-position 'right)
;;(setq neo-window-width 50)
;;(map! "<f2>" 'neotree-toggle)
;;(map! :n "C-f" 'neotree-find)

;; Treemacs
(setq treemacs-position 'right)
(setq treemacs-width 50)
(map! "S-<f2>" 'treemacs-display-current-project-exclusively)
(map! "<f2>" 'treemacs)
(map! :n "C-c" 'treemacs-find-file)

;; Keyboard mapping
(setq doom-leader-key ","
      doom-localleader-key "\\")

(map! "<f3>" 'ibuffer)
(map! "<f4>" 'find-file)
(map! "<f5>" 'recentf-open-files)
(map! "<f6>" 'projectile-find-file)
(map! "<f7>" 'bookmark-jump)
(map! "<f8>" 'occur)
(map! "S-<f8>" 'hi-lock-line-face-buffer)
(map! "<f10>" 'project-search)
(map! :n "SPC" 'forward-char)
(map! "C-w" 'other-window)

;; tabs movements
(undefine-key! '(normal visual) "TAB")
(map! :n "TAB" #'next-buffer)
(map! :n [backtab] 'previous-buffer)

;; disabling smartparens
(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

;; Faster leader menu trigger
(require 'which-key)
(setq which-key-idle-delay 0.1)


;; elixir lsp
;;
;; (use-package lsp-mode
;;              :commands lsp
;;              :ensure nil
;;              :diminish lsp-mode
;;              :hook
;;              (elixir-mode . lsp)
;;              :init
;;              (add-to-list 'exec-path "~/.elsp-1.11.2-otp-23")
;;              :config
;;              (setq lsp-enable-on-type-formatting nil
;;                    lsp-enable-file-watchers nil
;;                    lsp-enable-xref t
;;                    lsp-completition-enable t
;;                    lsp-prefer-flymake t))

(setq lsp-enable-file-watchers nil)
(setq lsp-file-watch-threshold 1000000)
(setq lsp-elixir-dialyzer-enabled nil)
(setq lsp-elixir-fetch-deps nil)
(setq lsp-elixir-mix-env "dev")
(setq lsp-elixir-enable-test-lenses nil)

;; (setq lsp-idle-delay 1.0)
;; (setq gc-cons-threshold (* 3 100000000))

;; go
(add-hook 'go-mode-hook
          (lambda ()
            (setq indent-tabs-mode 1)
            (setq tab-width 8)))


;; deft mode
(setq deft-directory "~/Dropbox/archive/deft"
      deft-extensions '("org" "txt")
      deft-recursive t)

;; journal
(setq org-journal-dir "~/Dropbox/archive")

;; clipboard
(setq select-enable-clipboard t)

;; helm
