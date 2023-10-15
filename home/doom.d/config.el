;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Dan Vonk"
      user-mail-address "dan@danvonk.com")

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
(setq doom-font (font-spec :family "JetBrains Mono" :size 14 :weight 'medium)
      doom-variable-pitch-font (font-spec :family "Noto Serif" :size 16 :weight 'regular))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'dichromacy)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/Notes")
(setq org-roam-directory "~/Documents/Notes")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


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

;;(use-package! 'ucs-normalize
;;  :before org-roam)
;; (use-package! websocket
    ;; :after org-roam)
(use-package! org-roam-ui
    :after org-roam ;; or :after org
        ;; normally we'd recommend hooking orui after org-roam, but since org-roam does not have
        ;; a hookable mode anymore, you're advised to pick something yourself
        ;; if you don't care about startup time, use
 :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(require 'ucs-normalize)

(add-hook 'org-mode-hook 'variable-pitch-mode)

(add-hook 'LaTeX-mode-hook
          (lambda ()
            ('variable-pitch-mode 'auto-fill-mode)))

(setq org-hide-emphasis-markers t)
(defun clang-format-save-hook-for-this-buffer ()
  "Create a buffer local save hook."
  (add-hook 'before-save-hook
            (lambda ()
              (when (locate-dominating-file "." ".clang-format")
                (clang-format-buffer))
              ;; Continue to save.
              nil)
            nil
            ;; Buffer local hook.
            t))

(setq lsp-clients-clangd-args
    '("--header-insertion=never"))
;; (add-hook 'c-mode-hook (lambda () (clang-format-save-hook-for-this-buffer)))
;; (add-hook 'c++-mode-hook (lambda () (clang-format-save-hook-for-this-buffer)))
;; (add-hook 'glsl-mode-hook (lambda () (clang-format-save-hook-for-this-buffer)))

;; tree sitter for emacs28
(use-package! tree-sitter)
(require 'tree-sitter-langs)
(global-tree-sitter-mode)
