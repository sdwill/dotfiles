;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Scott D. Will"
      user-mail-address "scott.d.will@nasa.gov")

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
(setq doom-font (font-spec :family "JetBrains Mono" :size 14))
      ;; doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-solarized-light)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/notes")


;; Disable autocompletion of dictionary words from company-ispell
;; See https://www.reddit.com/r/emacs/comments/p2iwbv/turn_off_companyispell/
;; (defun prog-mode-hook-setup ()
;;   (run-with-idle-timer
;;    1
;;    nil
;;    (lambda ()
;;      (when (memq 'company-ispell company-backends)
;;        (setq company-backends (delete 'company-ispell company-backends))))))
;; (add-hook 'prog-mode-hook 'prog-mode-hook-setup)

;; Alternative implementation of above
;; See https://zzamboni.org/post/my-doom-emacs-configuration-with-commentary/
(defun zz/adjust-org-company-backends ()
  (remove-hook 'after-change-major-mode-hook '+company-init-backends-h)
  (setq-local company-backends nil))
(add-hook! org-mode (zz/adjust-org-company-backends))

;; Autosave when leaving insert mode
;; See https://emacs.stackexchange.com/questions/50925/saving-file-everytime-leaving-insert-mode-in-evil-mode
(add-hook 'evil-insert-state-exit-hook
          (lambda ()
            (call-interactively #'evil-write)))

;; Start in maximized window
;; See https://emacs.stackexchange.com/a/3017/23435
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
;; Hide org markup
(after! org (setq org-hide-emphasis-markers t))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; Log done tasks in LOGBOOK
(after! org
  (setq org-log-done t)
  (setq org-log-into-drawer t))

;; Map a keybaord shortcut to insert inactive timestamp
(map! :localleader "d i" (cmd! (org-time-stamp '(16) t)))

(setq org-log-note-headings
      '((done . "CLOSING NOTE %t")
       (state . "State %-12s from %-12S %t")
       (note . "%t")
       (reschedule . "Rescheduled from %S on %t")
       (delschedule . "Not scheduled, was %S on %t")
       (redeadline . "New deadline from %S on %t")
       (deldeadline . "Removed deadline, was %S on %t")
       (refile . "Refiled on %t")
       (clock-out . "")))

;; When splitting window, prompt for which buffer to open
;; See https://tecosaur.github.io/emacs-config/config.html
(setq evil-vsplit-window-right t
      evil-split-window-below t)
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer))
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
