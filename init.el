(defun upsert-package (package) 
  (unless (package-installed-p package)
  (package-install package)))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;; (package-refresh-contents)

;; Download Evil
(upsert-package 'evil)

;; Enable Evil
(require 'evil)
(evil-mode 1)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(setq treesit-language-source-alist
  '((heex "https://github.com/phoenixframework/tree-sitter-heex")
    (elixir "https://github.com/elixir-lang/tree-sitter-elixir")
     (elisp "https://github.com/Wilfred/tree-sitter-elisp")
     (go "https://github.com/tree-sitter/tree-sitter-go")
     (cmake "https://github.com/uyha/tree-sitter-cmake")
     (bash "https://github.com/tree-sitter/tree-sitter-bash")
     (html "https://github.com/tree-sitter/tree-sitter-html")
     (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
     (json "https://github.com/tree-sitter/tree-sitter-json")
     (make "https://github.com/alemuller/tree-sitter-make")
     (markdown "https://github.com/ikatyang/tree-sitter-markdown")
     (toml "https://github.com/tree-sitter/tree-sitter-toml")
     (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
     (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
     (yaml "https://github.com/ikatyang/tree-sitter-yaml")
  ))

;; (mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist))

;; Elixir
(add-to-list 'major-mode-remap-alist
             '(elixir-mode . elixir-ts-mode))

(use-package
 eglot
 :ensure nil
 :config (add-to-list 'eglot-server-programs '(elixir-ts-mode "elixir-ls")))

(use-package
 elixir-ts-mode
 :hook (elixir-ts-mode . eglot-ensure)
 (elixir-ts-mode
  .
  (lambda ()
    (push '(">=" . ?\u2265) prettify-symbols-alist)
    (push '("<=" . ?\u2264) prettify-symbols-alist)
    (push '("!=" . ?\u2260) prettify-symbols-alist)
    (push '("==" . ?\u2A75) prettify-symbols-alist)
    (push '("=~" . ?\u2245) prettify-symbols-alist)
    (push '("<-" . ?\u2190) prettify-symbols-alist)
    (push '("->" . ?\u2192) prettify-symbols-alist)
    (push '("<-" . ?\u2190) prettify-symbols-alist)
    (push '("|>" . ?\u25B7) prettify-symbols-alist)))
 (before-save . eglot-format))

(require 'elixir-ts-mode)

(upsert-package 'smartparens)
(require 'smartparens-config)

(upsert-package 'google-this) 
(google-this-mode 1)

(upsert-package 'which-key)
(require 'which-key)
(setq which-key-idle-delay 0.05)
(setq which-key-idle-secondary-delay 0.05)
(which-key-mode)

(upsert-package 'deadgrep)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
