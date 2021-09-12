;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Pedro Antonio Messias Lemos"
      user-mail-address "peedroamlemos@gmail.com")

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
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 17 :weight 'semi-light)
	   doom-variable-pitch-font (font-spec :family "sans" :size 17))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)
(setq doom-themes-treemacs-theme "doom-dracula")

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(after! org
  (setq org-directory "~/Dropbox/Org")
  (setq org-agenda-files '("~/Dropbox/Org/Agenda/"))
  (setq org-log-done 'time)
  (setq org-todo-keywords '((sequence "TODO(t)" "PROJ(p)" "PROVA(P)" "TRAB(T)"
                                "WAIT(w)" "|" "DONE(d)" "CANCELLED(c)" "FINISHED(f)")))
)


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

; tree sitter config
(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;(auto-rename-tag-mode t)

;; ORG ROAM - CONFIG
(use-package org-roam
  :custom
  (org-roam-directory "~/Dropbox/Org/RoamNotes")
  (org-roam-complete-everywhere t)
  )
(org-id-update-id-locations (directory-files-recursively "~/Dropbox/Org/RoamNotes" ".org"))

;; ORG ROAM UI - CONFIG
(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
    :hook (org-roam . org-roam-ui-mode)
    :config
)

;; PDF - SETTINGS

;; (use-package pdf-view
;;   :hook (pdf-tools-enabled . pdf-view-midnight-minor-mode)
;;   :hook (pdf-tools-enabled . hide-mode-line-mode)
;;   :config
;;   (setq pdf-view-midnight-colors '("#ABB2BF" . "#282C35")))
(setenv "PKG_CONFIG_PATH" "/usr/share//pkgconfig:/usr/lib/pkgconfig")
(add-to-list 'org-file-apps '("\\.pdf\\'" . emacs))


; (after! org (setq org-startup-with-latex-preview t))
(setq org-hide-emphasis-markers t)

;; ORG LATEX - CONFIG
(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
;; (setq org-latex-pdf-process '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
;; (setq org-latex-listings 'minted)
;; (add-to-list 'org-latex-packages-alist '("" "minted"))

;; make latex bigger
(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))

;; COMPANY - CONFIG
(after! company
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 2)
  (setq company-show-quick-numbers t)
(add-hook 'evil-normal-state-entry-hook #'company-abort))
(setq doom-line-numbers-style 'relative)

;; EVIL MODE TWEAKS
(map! :n "j" #'evil-next-visual-line
      :n "k" #'evil-previous-visual-line)

