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
  (setq org-log-into-drawer t)
;; Map a keybaord shortcut to insert inactive timestamp
;; (map! :localleader "d i" (cmd! (org-time-stamp '(16) t)))
  (map! :localleader
        (:prefix ("d")
         (:desc "Insert current date+time" "i" (cmd! (org-time-stamp '(16) t)))))
  (setq org-log-note-headings
        '((done . "closing note %t")
          (state . "state %-12s from %-12s %t")
          (note . "%t")
          (reschedule . "rescheduled from %s on %t")
          (delschedule . "not scheduled, was %s on %t")
          (redeadline . "new deadline from %s on %t")
          (deldeadline . "removed deadline, was %s on %t")
          (refile . "refiled on %t")
          (clock-out . "")))
  ;; Setup TODO keywords
  (setq org-todo-keywords
        '((sequence "TODO(t)" "WIP(w)" "AWAIT(a)" "BLOCKED(b)" "IDEA(i)" "MEETING(m)" "|" "DONE(d)" "CANCELED(c)")
          (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[x](D)")))
  (setq org-agenda-files
        '("~/Documents/notes/journal/2022/"
          "~/Documents/notes/projects/fy22_irad.org"
          "~/Documents/notes/projects/rst.org"
          "~/gdrive/notes/personal.org"
          )))

(after! evil
  ;; When splitting window, prompt for which buffer to open
  ;; See https://tecosaur.github.io/emacs-config/config.html
  (setq evil-vsplit-window-right t
        evil-split-window-below t)
  (defadvice! prompt-for-buffer (&rest _)
    :after '(evil-window-split evil-window-vsplit) (consult-buffer))
  ;; (map! :n :leader "DEL" #'evil-ex-nohighlight)
)

;; Create clock table grouped by tags, see https://gist.github.com/ironchicken/6b5424bc2024b3d0a58a8a130f73c2ee
(defun clocktable-by-tag/shift-cell (n)
  (let ((str ""))
    (dotimes (i n)
      (setq str (concat str "| ")))
    str))

(defun clocktable-by-tag/insert-tag (params)
  (let ((tag (plist-get params :tags)))
    (insert "|--\n")
    (insert (format "| %s | *Tag time* |\n" tag))
    (let ((total 0))
      (mapcar
       (lambda (file)
         (let ((clock-data (with-current-buffer (find-file-noselect file)
                             (org-clock-get-table-data (buffer-name) params))))
           (when (> (nth 1 clock-data) 0)
             (setq total (+ total (nth 1 clock-data)))
             (insert (format "| | File *%s* | %.2f |\n"
                             (file-name-nondirectory file)
                             (/ (nth 1 clock-data) 60.0)))
             (dolist (entry (nth 2 clock-data))
               (insert (format "| | . %s%s | %s %.2f |\n"
                               (org-clocktable-indent-string (nth 0 entry))
                               (nth 1 entry)
                               (clocktable-by-tag/shift-cell (nth 0 entry))
                               (/ (nth 4 entry) 60.0)))))))
       (org-agenda-files))
      (save-excursion
        (re-search-backward "*Tag time*")
        (org-table-next-field)
        (org-table-blank-field)
        (insert (format "*%.2f*" (/ total 60.0)))))
    (org-table-align)))

(defun org-dblock-write:clocktable-by-tag (params)
  (insert "| Tag | Headline | Time (h) |\n")
  (insert "|     |          | <r>  |\n")
  (let ((tags (plist-get params :tags)))
    (mapcar (lambda (tag)
              (clocktable-by-tag/insert-tag (plist-put (plist-put params :match tag) :tags tag)))
            tags)))
;; Don't raise/lower super/subscripts
;; See https://github.com/ymarco/doom-emacs-config/blob/master/latex-config.el
(setq font-latex-fontify-script nil)

;; (let ((org-super-agenda-groups
;;        '(;; Each group has an implicit boolean OR operator between its selectors.
;;          (:name "Today"  ; Optionally specify section name
;;                 :time-grid t  ; Items that appear on the time grid
;;                 :todo "TODAY")  ; Items that have this TODO keyword
;;          (:name "Important"
;;                 ;; Single arguments given alone
;;                 :tag "bills"
;;                 :priority "A")
;;          ;; Set order of multiple groups at once
;;          (:order-multi (2 (:name "Shopping in town"
;;                                  ;; Boolean AND group matches items that match all subgroups
;;                                  :and (:tag "shopping" :tag "@town"))
;;                           (:name "Food-related"
;;                                  ;; Multiple args given in list with implicit OR
;;                                  :tag ("food" "dinner"))
;;                           (:name "Personal"
;;                                  :habit t
;;                                  :tag "personal")
;;                           (:name "Space-related (non-moon-or-planet-related)"
;;                                  ;; Regexps match case-insensitively on the entire entry
;;                                  :and (:regexp ("space" "NASA")
;;                                                ;; Boolean NOT also has implicit OR between selectors
;;                                                :not (:regexp "moon" :tag "planet")))))
;;          ;; Groups supply their own section names when none are given
;;          (:todo "WAITING" :order 8)  ; Set order of this section
;;          (:todo ("SOMEDAY" "TO-READ" "CHECK" "TO-WATCH" "WATCHING")
;;                 ;; Show this group at the end of the agenda (since it has the
;;                 ;; highest number). If you specified this group last, items
;;                 ;; with these todo keywords that e.g. have priority A would be
;;                 ;; displayed in that group instead, because items are grouped
;;                 ;; out in the order the groups are listed.
;;                 :order 9)
;;          (:priority<= "B"
;;                       ;; Show this section after "Today" and "Important", because
;;                       ;; their order is unspecified, defaulting to 0. Sections
;;                       ;; are displayed lowest-number-first.
;;                       :order 1)
;;          ;; After the last group, the agenda will display items that didn't
;;          ;; match any of these groups, with the default order position of 99
;;          )))
;;   (org-agenda nil "a"))

;; (use-package! org-super-agenda
;;   :after org-agenda
;;   :init
;;   (setq org-agenda-skip-scheduled-if-done t
;;         org-agenda-skip-deadline-if-done t
;;         org-agenda-include-deadlines t
;;         org-agenda-block-separator nil
;;         org-agenda-compact-blocks t
;;         org-agenda-start-day nil ;; i.e. today
;;         org-agenda-span 1
;;         org-agenda-start-on-weekday nil)
;;   (setq org-super-agenda-groups
;;       '((:name "Next Items"
;;          :time-grid t
;;          :tag ("NEXT" "outbox"))
;;         (:name "Important"
;;          :priority "A")
;;         (:priority<= "B"
;;          :scheduled future
;;          :order 1)))
;;   :config
;;   (org-super-agenda-mode))

;; Setup org-super-agenda
(use-package! org-super-agenda
  :after org-agenda
  :init
  (setq org-agenda-skip-scheduled-if-done t
        org-agenda-skip-deadline-if-done t
        org-agenda-include-deadlines t
        org-agenda-block-separator nil
        org-agenda-compact-blocks t
        org-agenda-start-day nil ;; i.e. today
        org-agenda-span 1
        org-agenda-start-on-weekday nil)
  (setq org-super-agenda-groups
         '(
           (:name "IRAD"
            :tag "irad"
            :order 2)
           (:name "RST"
            :tag "rst"
            :order 3)
           (:name "General"
            :and (:tag "general" :tag "admin")
            :order 4)
           (:name "Study"
            :tag "study"
            :order 5)
           (:name "Personal"
            :tag "personal"
            :order 6)
           (:name "Waiting..."
            :todo "AWAIT"
            :order 98)
           (:name "Blocked..."
            :todo "BLOCKED"
            :order 99)
           (:name "Scheduled Soon"
            :scheduled future
            :order 8)
           (:name "Meetings"
            :and (:todo "MEET" :scheduled future)
            :order 10)
           (:name "Today"
            :time-grid t
            :scheduled today
            :order 1))
         )
        ;; ((agenda "" ((org-agenda-overriding-header "")
        ;;     (alltodo "" ((org-agenda-overriding-header "")
        ;;                  (org-super-agenda-groups
        ;;                   '((:log t)
        ;;                     (:name "Today"
        ;;                            :scheduled today
        ;;                            :order 1)
        ;;                     (:name "Important"
        ;;                            :priority "A"
        ;;                            :order 6)
        ;;                     (:name "Due Today"
        ;;                            :deadline today
        ;;                            :order 2)
        ;;                     (:name "Scheduled Soon"
        ;;                            :scheduled future
        ;;                            :order 8)
        ;;                     (:name "Overdue"
        ;;                            :deadline past
        ;;                            :order 7)
        ;;                     (:discard (:not (:todo "TODO")))))))))
  :config
  (org-super-agenda-mode))

;; Stop org-super-agenda from clobbering evil mode keybinds
;; Tried suggestion found here: https://github.com/alphapapa/org-super-agenda/issues/50
(setq org-super-agenda-header-map (make-sparse-keymap))
;;
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
