(add-to-list 'load-path "~/.emacs.d/site-lisp")

;; vimpulse
(setq viper-mode t)                ; enable Viper at load time
(setq viper-ex-style-editing nil)  ; can backspace past start of insert / line
(require 'viper)                   ; load Viper
(require 'vimpulse)                ; load Vimpulse
(setq woman-use-own-frame nil)     ; don't create new frame for manpages
(setq woman-use-topic-at-point t)  ; don't prompt upon K key (manpage display)

(define-key viper-insert-global-user-map (kbd "C-c") 'viper-intercept-ESC-key)
(define-key viper-insert-global-user-map (kbd "ESC") 'viper-intercept-ESC-key)
(define-key viper-vi-global-user-map "\C-wv" 'split-window-horizontally)

(define-key viper-insert-global-user-map (kbd "C-s") 'save-buffer)
(define-key viper-vi-global-user-map "\C-s" 'save-buffer)
(define-key viper-vi-global-user-map (kbd "<F5>") 'save-buffer)
(global-unset-key "\M-k")
;(global-set-key (kbd "C-s") 'save-buffer)
;(global-set-key (kbd "<F5>") 'save-buffer)

;; slime
;(add-to-list 'load-path "/the/path/to/slime")
(require 'slime)
(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
(setq inferior-lisp-program "/usr/bin/sbcl") 

;;;;;;;;
(mouse-wheel-mode t)
(xterm-mouse-mode t)
(setq inhibit-startup-message t)
(setq require-final-newline t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq search-highlight t)

