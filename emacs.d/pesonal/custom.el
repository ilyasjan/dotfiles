(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t) ; Org-mode's repository
(defun ensure-package-installed (&rest packages)
  (mapcar
   (lambda (package)
     ;; (package-installed-p 'evil)
     (if (package-installed-p package)
         nil
       (if t
           (package-install package)
         package)))
   packages))

(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;;add your packages here
(ensure-package-installed 'htmlize
                          'smart-mode-line
                          'git-gutter
                          'project-explorer
                          'niflheim-theme
                          'paredit 'speed-type
                          'magit-gitflow
                          'monokai-theme)
;;init
(package-initialize)
;;this has to be on top. or modications require confirmation
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(magit-use-overlays nil)
 '(package-selected-packages
   (quote
    (monokai-theme magit-gitflow speed-type paredit niflheim-theme project-explorer git-gutter smart-mode-line htmlize zop-to-char zenburn-theme yesql-ghosts web-mode volatile-highlights vkill undo-tree smex smartrep smartparens slime rainbow-mode rainbow-delimiters ov operate-on-number move-text mediawiki markdown-mode magit key-chord json-mode js2-mode ido-ubiquitous helm-projectile helm-descbinds helm-ag haskell-mode guru-mode grizzl god-mode gitignore-mode gitconfig-mode git-timemachine gist geiser flycheck flx-ido expand-region exec-path-from-shell elisp-slime-nav easy-kill dockerfile-mode discover-my-major diminish diff-hl company-auctex company-anaconda coffee-mode cdlatex browse-kill-ring anzu ace-window ace-jump-buffer))))




;;ui tweaks
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(load-theme 'monokai t)
(global-hl-line-mode -1)

;; personal styling
(set-default-font "Fira Code 16")
;;https://github.com/tonsky/FiraCode
                                        ;(set-face-attribute 'default nil :height 140)
(scroll-bar-mode -1)

;; show line numbers
(global-linum-mode +1)

(setq linum-format "%4d\u2502")

;; change command and option key
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

;; you know mac
(keyboard-translate ?\C-x ?\C-u)
(keyboard-translate ?\C-u ?\C-x)

;; smart mode line.
(require 'smart-mode-line)
(sml/setup)



(setenv "PATH"
        (concat
         "/usr/local/bin/" ":"
         (getenv "PATH") ; inherited from OS
         ))

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))
;;let's add real shortcut for eshell


;; No splash screen please ... jeez
(setq inhibit-startup-message t)

(require 'clojure-mode)
(require 'cider)
 ;; clojure related stuff
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq nrepl-log-messages t)
(setq nrepl-hide-special-buffers t)
(setq cider-prefer-local-resources t)
(setq cider-repl-pop-to-buffer-on-connect nil)
(setq cider-show-error-buffer nil)
(setq cider-auto-select-error-buffer nil)
(setq cider-stacktrace-default-filters '(tooling dup))
(setq cider-stacktrace-fill-column 80)
(setq nrepl-buffer-name-separator "-")
(setq nrepl-buffer-name-show-port t)
(setq cider-repl-display-in-current-window t)
(setq cider-prompt-save-file-on-load nil)
(setq cider-repl-result-prefix ";; => ")
(setq cider-interactive-eval-result-prefix ";; => ")
(setq cider-repl-use-clojure-font-lock t)
(setq cider-switch-to-repl-command 'cider-switch-to-current-repl-buffer)
(setq cider-repl-wrap-history t)
(setq cider-repl-history-size 1000)

(add-hook 'cider-repl-mode-hook 'company-mode)
(add-hook 'cider-mode-hook 'company-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'subword-mode)
(add-hook 'cider-repl-mode-hook 'smartparens-strict-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)

;; tramp , remote file manipulation
(setq tramp-chunksize 500)
(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))
(setq tramp-debug-buffer t)
(setq tramp-verbose 10)


;;changing default temp dir
(put 'temporary-file-directory 'standard-value '((file-name-as-directory "/tmp")))
;; snippets , this is working quite nice now.
;; Custom blog related stuff
(require 'htmlize)
(setq org-html-htmlize-output-type 'inline-css)
(setq org-html-validation-link nil)
(setq org-publish-project-alist
      '(("org-notes"
         ;; Directory for source files in org format
         :base-directory "~/Blogs/"
         :base-extension "org"
         ;; HTML directory
         :publishing-directory "~/public_htmls/"
         :publishing-function org-html-publish-to-html
         :recursive t
         :headline-levels 4
         :section-numbers nil
         :auto-preamble t
         :html-postamble-format "%a %d" ;write author and date at end
         :auto-sitemap t
         :sitemap-title "rodin"
         :sitemap-filename "index"
         :sitemap-sort-files anti-chronologically
         :sitemap-file-entry-format "%t (%d)" ;write title and date in sm
         )

        ;; where static files (images, pdfs) are stored
        ("org-static"
         :base-directory "~/Blogs/statics/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/public_htmls/statics/"
         :recursive t
         :publishing-function org-publish-attachment
         )

        ("blog" :components ("org-notes"
                             "org-static"))))

(setq org-src-fontify-natively t)
;(set-input-mode t nil t)


(require 'erc-join)
(setq erc-hide-list '("JOIN" "PART" "QUIT"))
(erc-autojoin-mode 1)
(setq erc-max-buffer-size 700000)
(setq erc-autojoin-channels-alist
      '(("freenode.net" "#emacs"  "#statistics"
         "#R"  "#machinelearning"  "#lisp"  "#git"
         "#networking" "#reactjs" "#clojure")))


(require 'magit-gitflow)
(add-hook 'magit-mode-hook 'turn-on-magit-gitflow)

;; full screen magit-status
(defun magit-toggle-whitespace ()
  (interactive)
  (if (member "-w" magit-diff-options)
      (magit-dont-ignore-whitespace)
    (magit-ignore-whitespace)))

(defun magit-ignore-whitespace ()
  (interactive)
  (add-to-list 'magit-diff-options "-w")
  (magit-refresh))

(defun magit-dont-ignore-whitespace ()
  (interactive)
  (setq magit-diff-options (remove "-w" magit-diff-options))
  (magit-refresh))

(define-key magit-status-mode-map (kbd "W") 'magit-toggle-whitespace)

(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(defun magit-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

(define-key magit-status-mode-map (kbd "q") 'magit-quit-session)


;; let's make changed code visible to us.
(require 'git-gutter)
(global-git-gutter-mode +1)


;; background color ,modified for monokai
(set-face-foreground 'git-gutter:modified "#282828") ;; background color
(set-face-foreground 'git-gutter:added "#282828")
(set-face-foreground 'git-gutter:deleted "#282828")


;; line management
(defun open-line-below ()
  (interactive)
  (end-of-line)
  (newline)
  (indent-for-tab-command))

(defun open-line-above ()
  (interactive)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-for-tab-command))

(global-set-key (kbd "<C-return>") 'open-line-below)
(global-set-key (kbd "<C-S-return>") 'open-line-above)

;; jumping made a little bit easier
;; Move more quickly
(global-set-key (kbd "C-S-n")
                (lambda ()
                  (interactive)
                  (ignore-errors (next-line 5))))

(global-set-key (kbd "C-S-p")
                (lambda ()
                  (interactive)
                  (ignore-errors (previous-line 5))))

(global-set-key (kbd "C-S-f")
                (lambda ()
                  (interactive)
                  (ignore-errors (forward-char 5))))

(global-set-key (kbd "C-S-b")
                (lambda ()
                  (interactive)
                  (ignore-errors (backward-char 5))))




;; basic movement
;;(global-set-key (kbd "M-c") 'previous-line)
;;(global-set-key (kbd "M-t") 'next-line)
;;(global-set-key (kbd "M-h") 'backward-char)
;;(global-set-key (kbd "M-n") 'forward-char)


;;(global-set-key (kbd "M-C") 'scroll-down)
;;(global-set-key (kbd "M-T") 'scroll-up)


;;(global-set-key (kbd "M-H") 'scroll-down-command)
;;(global-set-key (kbd "M-N") 'scroll-up-command)

(global-set-key (kbd "M-g") 'backward-word)
(global-set-key (kbd "M-r") 'forward-word)

(global-set-key (kbd "M-G") 'beginning-of-buffer)
(global-set-key (kbd "M-R") 'end-of-buffer)


(global-set-key (kbd "M-e") 'delete-forward-char)
(global-set-key (kbd "M-u") 'delete-backward-char)

(global-set-key (kbd "M-.") 'backward-kill-word)
(global-set-key (kbd "M-p") 'kill-word)



(key-chord-define-global "''" 'other-window)
(key-chord-define-global ",," 'prelude-switch-to-previous-buffer)
(key-chord-define-global "aa" 'helm-mini)
(key-chord-define-global "ww" 'magit-status)
(key-chord-define-global "!!" 'cider-jack-in)
(key-chord-define-global "@@" 'cider-restart)
(key-chord-define-global "$$" 'project-explorer-open)
(key-chord-define-global "zz" 'cider-connect)
(key-chord-define-global "&&" 'shell)



(setq cider-test-show-report-on-success t)

(require 'cider-mode)
(require 'clojure-mode)
(define-key clojure-mode-map (kbd "C-x y") 'cider-eval-last-sexp-and-append)
(define-key clojure-mode-map (kbd "C-x j") 'cider-jack-in)
(define-key clojure-mode-map (kbd "C-x J") 'cider-restart)
(define-key clojure-mode-map (kbd "C-x F") 'cider-format-buffer)


(define-key helm-find-files-map (kbd "<tab>") 'helm-execute-persistent-action)





(defun yui-compress ()
  (interactive)
  (call-process-region
   (point-min) (point-max) "yuicompressor" t t nil (buffer-file-name)))

;; avoid pe from blowing up
(defcustom pe/omit-regex "^\\.\\|^#\\|~\\|node_modules\\|target$"
  "Specify which files to omit.
Directories matching this regular expression won't be traversed."
  :group 'project-explorer
  :type '(choice
          (const :tag "Show all files" nil)
          (string :tag "Files matching this regex won't be shown")))

;;(setq cider-known-endpoints '(("nlp" "nlp@xjunlp" "55555" )
;;                              ("linode" "root@clj.me" "55555")
;;                              ("localhost" "yusup@127.0.0.1" "55555")))


;;; Greek letters - C-u C-\ greek ;; C-\ to revert to default
;;; ς ε ρ τ υ θ ι ο π α σ δ φ γ η ξ κ λ ζ χ ψ ω β ν μ
(defvar mode-line-cleaner-alist
  `((auto-complete-mode . " α")
    (yas-minor-mode . " γ")
    (paredit-mode . " Φ")
    (eldoc-mode . "")
    (abbrev-mode . "")
    (undo-tree-mode . " τ")
    (volatile-highlights-mode . " υ")
    (elisp-slime-nav-mode . " δ")
    (nrepl-mode . " ηζ")
    (nrepl-interaction-mode . " ηζ")
    ;; Major modes
    (clojure-mode . " λ")
    (hi-lock-mode . "")
    (python-mode . " Py")
    (git-gutter-mode . " gg")
    (helm-mode . " h")
    (company-mode . " c")
    (projectile-mode . " pt")
    (flycheck-mode . " fc")
    (guru-mode . " g")
    (emacs-lisp-mode . " el")
    (markdown-mode . " md"))
  "Alist for `clean-mode-line'.

When you add a new element to the alist, keep in mind that you
must pass the correct minor/major mode symbol and a string you
want to use in the modeline *in lieu of* the original.")
(defun clean-mode-line ()
  (interactive)
  (loop for cleaner in mode-line-cleaner-alist
        do (let* ((mode (car cleaner))
                 (mode-str (cdr cleaner))
                 (old-mode-str (cdr (assq mode minor-mode-alist))))
             (when old-mode-str
                 (setcar old-mode-str mode-str))
               ;; major mode
             (when (eq mode major-mode)
               (setq mode-name mode-str)))))

(add-hook 'after-change-major-mode-hook 'clean-mode-line)


;;refresh all namespaces
(defun nrepl-refresh ()
  (interactive)
  (call-interactively 'cider-switch-to-relevant-repl-buffer)
  (goto-char (point-max))
  (insert "(clojure.tools.namespace.repl/refresh)")
  (cider-repl-return))

;; reset your system
(defun nrepl-reset ()
  (interactive)
  (call-interactively 'cider-switch-to-relevant-repl-buffer)
  (goto-char (point-max))
  (insert "(user/reset)")
  (cider-repl-return))

(defun temp-buffer ()
  (interactive)
  (switch-to-buffer "*temp*"))


(defun detabify-buffer ()
  "Calls untabify on the current buffer"
  (interactive)
  (untabify (point-min) (point-max)))

(defun clean-up-whitespace ()
  "Calls untabify and delete-trailing-whitespace on the current buffer."
  (interactive)
  (detabify-buffer)
  (delete-trailing-whitespace))

(defun mbp-clojure-mode-keybindings ()
  (local-set-key (kbd "<f1>") 'nrepl-reset)
  (local-set-key (kbd "<f2>") 'nrepl-refresh))

(global-set-key (kbd "C-x t") 'temp-buffer)
;;awesome buffer

(add-hook 'clojure-mode-hook 'mbp-clojure-mode-keybindings)

;; this whitespace is kinda killing me
;(setq prelude-whitespace nil)
;(setq prelude-clean-whitespace-on-save nil)
(setq prelude-flyspell nil)
(require 'whitespace)
(setq whitespace-line-column 80000) ;; limit line length
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;encoding;
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; backwards compatibility as default-buffer-file-coding-system
;; is deprecated in 23.2.
(if (boundp 'buffer-file-coding-system)
    (setq-default buffer-file-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8))

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
(require 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;;annoying whitespace
(setq whitespace-style (quote (spaces tabs newline space-mark tab-mark newline-mark)))
(setq whitespace-display-mappings
      ;; all numbers are Unicode codepoint in decimal. try (insert-char 182 ) to see it
      '(
        ;;(space-mark 32 [183] [46]) ; 32 SPACE, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
        ;;(newline-mark 10 [182 10]) ; 10 LINE FEED
        (tab-mark 9 [9655 9] [92 9]) ; 9 TAB, 9655 WHITE RIGHT-POINTING TRIANGLE 「▷」
        ))
