;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
       '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    yaml-mode
    elpy
    py-autopep8
    material-theme
    flycheck
    jedi
    magit))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; CUSTOM FUNCTIONS & SETTINGS
;; --------------------------------------
(electric-pair-mode 1)
(global-magit-file-mode 1)
(setq electric-pair-pairs
      '(
        (?\" . ?\")
        (?\{ . ?\})))

(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))

(defun insert-doc-comment () (interactive)
   (insert "/**\n * Brief description. Long description. \n * @param \n * @return \n * @exception \n * @see \n * @author \n */"))

;; BASIC CUSTOMIZATION
;; --------------------------------------

(prefer-coding-system 'utf-8)
;;(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; enable material-theme
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#263238" :foreground "#ffffff" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 108 :width normal :foundry "outline" :family "Monaco")))))

(global-linum-mode t) ;; enable line numbers globally
;; Global key bindings 
(global-set-key (kbd "C-<tab>") #'indent-rigidly-right) ;; add indentation step on selection
(global-set-key (kbd "S-<tab>") #'indent-rigidly-left) ;; remove indentation step on selection
(global-set-key (kbd "C-:") #'toggle-comment-on-line) ;; toggle comment
(global-set-key (kbd "C-.") #'comment-dwim) ;; toggle comment at the end of line
(global-set-key (kbd "C-x g") 'magit-status)

;; YAML CONFIGURATION
;; --------------------------------------

(add-hook 'yaml-mode-hook
          (lambda ()
            (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)
(require 'py-autopep8) ;; enable autopep8 formatting on save
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
(setq py-autopep8-options '("--max-line-length=120"))
(autoload 'jedi:setup "jedi" nil t)
(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook 'flycheck-mode)
(setq jedi:complete-on-dot t)                 ; optional


(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (async magit yasnippet-snippets yaml-mode rope-read-mode py-autopep8 material-theme leuven-theme jedi flycheck elpy better-defaults))))
