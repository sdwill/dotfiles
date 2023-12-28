;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Scott D. Will"
      user-mail-address "scott.d.will@nasa.gov")

(setq doom-font (font-spec :family "Victor Mono" :size 16 :weight 'medium)
      doom-variable-pitch-font (font-spec :family "IBM Plex Sans" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-catppuccin)
;; (setq doom-catppuccin-dark-variant "latte")
;; (setq doom-theme 'doom-nord-light)
;; (load-theme 'catppuccin-latte)
(setq doom-theme 'catppuccin-latte)

;; (defun prog-mode-hook-setup ()
;;   (run-with-idle-timer
;;    1
;;    nil
;;    (lambda ()
;;      (when (memq 'company-ispell company-backends)
;;        (setq company-backends (delete 'company-ispell company-backends))))))
;; (add-hook 'prog-mode-hook 'prog-mode-hook-setup)

(defun zz/adjust-org-company-backends ()
  (remove-hook 'after-change-major-mode-hook '+company-init-backends-h)
  (setq-local company-backends nil))
(add-hook! org-mode (zz/adjust-org-company-backends))

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(global-display-line-numbers-mode)
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/notes")

(after! org
  (setq org-log-done 'time)
  (setq org-log-into-drawer t))

(after! org
  (setq org-duration-format 'h:mm))

(after! org
  (map! :leader
        (:prefix ("md")
         (:desc "Insert current date+time" "i" (cmd! (org-time-stamp '(16) t))))))

(after! org
  (setq org-log-note-headings
        '((done . "%t Closing note")
          (state . "%t State %s from %S")
          (note . "%t")
          (refile . "%t Refiled")
          (clock-out . ""))))

(after! org
  (setq org-todo-keywords
        '((sequence "TODO(t)" "AWAIT(a)" "BLOCKED(b)" "IDEA(i)" "|" "DONE(d)" "CANCELED(c)")
          (sequence "MEETING(m)" "EVENT(v)" "|" "ENDED(e)" "CANCELED(c)" "SKIPPED(s)")
          (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[x](D)")))
  )

(after! org
  (setq org-startup-folded t))

(after! org
  (setq org-agenda-files
        '("~/Documents/notes/journal/2022/"
          "~/Documents/notes/projects/irad_fy22.org"
          "~/Documents/notes/projects/rst.org"
          "~/Documents/notes/projects/ldfc.org"
          "~/notes/personal.org"
          )))

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
        org-agenda-start-on-weekday nil
        org-agenda-start-with-log-mode t)
  (setq org-agenda-custom-commands
        '(("z" "Super agenda"
           ((agenda "" ((org-agenda-span 'day)
                        (org-super-agenda-groups
                         '(
                            (:name "Birthdays"
                             :tag "birthdays"
                             :order 97)
                           ))))))
          ("t" "Super tasks"
            ((alltodo "" ((org-agenda-overriding-header "")
                         (org-super-agenda-groups
                          '(
                            (:name "Upcoming deadlines"
                             :deadline future
                             :order 99)
                             ))))))
          ))
  :config
  (org-super-agenda-mode))

(setq org-super-agenda-header-map (make-sparse-keymap))

(defun org-dblock-write:sjm/org-insert-agenda (params)
  "Writes agenda items with some some text from the entry as context
to dynamic block.
Parameters are:

:key

  If key is a string of length 1, it is used as a key in
  `org-agenda-custom-commands` and triggers that command.  If it
  is a longer string it is used as a tags/todo match string.

:leaders

  String to insert before context text.  Defaults to two spaces \"  \".
  Do not use asterisk \"* \".

:count

  Maximum number of lines to include, defaults to
  org-agenda-entry-text-maxlines

:replace-what

  Regex to replace.  Defaults to heading asterisk characters and
  first uppercase word (TODO label): \"^\\* [A-Z-]* \"

:replace-with

  String to replace the org-heading star with.
  Defaults to \"- \" such that headings become list items.

Somewhat adapted from org-batch-agenda.
"
  (let ((data)
    (cmd-key (or (plist-get params :key) "b"))
    (org-agenda-entry-text-leaders (or (plist-get params :leaders) "  "))
    (org-agenda-entry-text-maxlines (or (plist-get params :count)
                        org-agenda-entry-text-maxlines))
    (replace-this (or (plist-get params :repalce-this) "^\\* [A-Z-]* "))
    (replace-with (or (plist-get params :replace-with) "- "))
    (org-agenda-sticky))
    (save-window-excursion ; Return to current  buffer and window when done.
      (if (> (length cmd-key) 1) ; If key is more than one character, THEN
      (org-tags-view nil cmd-key) ; Invoke tags view, ELSE
    (org-agenda nil cmd-key)) ; Invoke agenda view using key provided.
    (setq data (buffer-string)) ; copy agenda buffer contents to data
    (with-temp-buffer ; Using a temporary buffer to manipulate text.
      (insert data) ; place agenda data into buffer.
      (goto-char (point-max)) ; end-of-buffer
      (beginning-of-line 1)   ; beggining of last line.
      (while (not (bobp)) ; while not begging of buffer
        (when (org-get-at-bol 'org-hd-marker) ; get text property.
          (sjm/org-agenda-entry-text)) ; Insert item context underneath.
        (beginning-of-line 0)) ; Go to previous line
      (setq data (buffer-string)))) ; Copy buffer, close tmp buf & excursion.
    ;; Paste data, replacing asterisk as per replace-this with replace-with.
    (insert (replace-regexp-in-string replace-this replace-with data))))

                    ;
(defun sjm/org-agenda-entry-text ()
  "Insert some text from the current agenda item as context.
Adapted from `org-agenda-entry-text-show-here', relies upon
`org-agenda-get-some-entry-text' for the bulk of the work."
  (save-excursion ; return to current place in buffer.
    (let (m txt o) ; declare some local variables.
    (setq m (org-get-at-bol 'org-hd-marker)) ; get text property
    (unless (marker-buffer m) ; get buffer that marker points into.
      (error "No marker points to an entry here"))
    ;; get some entry text, remove any properties and append a new-line.
    (setq txt (concat "\n" (org-no-properties
                (org-agenda-get-some-entry-text
                 m org-agenda-entry-text-maxlines
                 org-agenda-entry-text-leaders))))
    (when (string-match "\\S-" txt)
      (forward-line 1)
      (insert txt "\n\n")))))

(after! org
  (setq +org-capture-todo-file "~/Documents/notes/journal/2022/todo.org"))

(after! org
  (setq org-capture-templates
        '(
          ("t" "Todo" entry (file+headline +org-capture-todo-file "Inbox")
           "* TODO %?\n%U" :empty-lines 1)
          ("p" "Personal" entry (file+headline "~/gdrive/notes/personal.org" "Inbox")
           "* TODO %?\n%U" :empty-lines 1)
          ("b" "Book" entry (file+headline "~/notes/books.org" "Inbox")
           "* TODO %?\n%U" :empty-lines 1)
          )))
;; (setq org-capture-templates
;;       '(("t" "Personal todo" entry (file+headline +org-capture-todo-file "Inbox")
;;          "* TODO %?\n %i\n %a" :prepend t)
;;         ("n" "Personal notes" entry (file+headline +org-capture-notes-file "Inbox") "* %u %? %i %a" :prepend t)
;;         ("j" "Journal" entry (file+olp+datetree +org-capture-journal-file) "* %U %? %i %a" :prepend t)
;;         ("p" "Templates for projects") ("pt" "Project-local todo" entry (file+headline +org-capture-project-todo-file "Inbox") "* TODO %? %i %a" :prepend t)
;;         ("pn" "Project-local notes" entry (file+headline +org-capture-project-notes-file "Inbox") "* %U %? %i %a" :prepend t)
;;         ("pc" "Project-local changelog" entry (file+headline +org-capture-project-changelog-file "Unreleased") "* %U %? %i %a" :prepend t)
;;         ("o" "Centralized templates for projects") ("ot" "Project todo" entry #'+org-capture-central-project-todo-file "* TODO %? %i %a" :heading "Tasks" :prepend nil)
;;         ("on" "Project notes" entry #'+org-capture-central-project-notes-file "* %U %? %i %a" :heading "Notes" :prepend t)
;;         ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file "* %U %? %i %a" :heading "Changelog" :prepend t)))

(after! org-clock
  (setq org-clock-persist t)
  (org-clock-persistence-insinuate))

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

(after! org
  (push '("\\.docx?\\'" . "open %s") org-file-apps))

(after! org
  (setq org-reverse-note-order t)
)

(after! org (setq org-image-actual-width 300))

(setq image-file-name-extensions '("png" "jpeg" "jpg" "gif" "tiff" "tif" "xbm" "xpm" "pbm" "pgm" "ppm" "pnm" "svg" "heic")
)

(setq font-latex-fontify-script nil)

;; (add-hook 'evil-insert-state-exit-hook
;;           (lambda ()
;;             (call-interactively #'evil-write)))

(after! evil
  (setq evil-vsplit-window-right t
        evil-split-window-below t)
  (defadvice! prompt-for-buffer (&rest _)
    :after '(evil-window-split evil-window-vsplit) (projectile-find-file)))

(after! evil
  (map! :leader "DEL" (cmd! (evil-ex-nohighlight))))

(after! vterm
  (map! :leader "\\" (cmd! (+vterm/toggle nil))))

(defun my/vterm-execute-current-line ()
    "Send text of current line to vterm."
    (interactive)
    (require 'vterm)
    (eval-when-compile (require 'subr-x))
    (let ((command (string-trim (buffer-substring
                                (save-excursion
                                    (beginning-of-line)
                                    (point))
                                (save-excursion
                                    (end-of-line)
                                    (point))))))
    (let ((buf (current-buffer)))
        (unless (get-buffer vterm-buffer-name)
        (vterm))
        (display-buffer vterm-buffer-name t)
        (switch-to-buffer-other-window vterm-buffer-name)
        (vterm--goto-line -1)
        (message command)
        (vterm-send-string command)
        )))
