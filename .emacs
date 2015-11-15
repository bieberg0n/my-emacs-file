;========外观========
;关闭起动时的那个“开机画面”
(setq inhibit-startup-message t)
;显示列号
;(setq column-number-mode t)
;显示括号匹配
(show-paren-mode 0)
;去掉工具栏/菜单栏/滚动条
;(tool-bar-mode 0)
(menu-bar-mode 0)
;(scroll-bar-mode 0)
;缺省模式 text-mode
(setq default-major-mode 'text-mode)
;语法加亮
(global-font-lock-mode t)
;高亮显示区域选择
(transient-mark-mode t)
;页面平滑滚动， scroll-margin 3 靠近屏幕边沿3行时开始滚动，可以很好的看到上下文。
(setq scroll-margin 3
scroll-conservatively 10000)
;自动换行
;; (global-visual-line-mode 1)
;=========功能==========
;设定不产生备份文件
(setq make-backup-files nil)
(setq auto-save-default 0)
;在行首 C-k 时，同时删除该行。
(setq-default kill-whole-line t)
;只渲染当前屏幕语法高亮，加快显示速度
(setq lazy-lock-defer-on-scrolling t)
;(setq font-lock-support-mode 'lazy-lock-mode)
(setq font-lock-maximum-decoration t)
;回车自动缩进
(global-set-key (kbd "RET") 'newline-and-indent)
;使用y or n提问
(fset 'yes-or-no-p 'y-or-n-p)
;4格缩进
(setq default-tab-width 4)
;go to char
(defun my-go-to-char (n char)
    "Move forward to Nth occurence of CHAR.
Typing `my-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
	(interactive "p\ncGo to char: ")
	(let ((case-fold-search nil))
	  (if (eq n 1)
		  (progn                            ; forward
			(search-forward (string char) nil nil n)
			(backward-char)
			(while (equal (read-key)
						  char)
			  (forward-char)
			  (search-forward (string char) nil nil n)
			  (backward-char)))
		(progn                              ; backward
		  (search-backward (string char) nil nil )
		  (while (equal (read-key)
						char)
			(search-backward (string char) nil nil )))))
	(setq unread-command-events (list last-input-event)))
(global-set-key (kbd "C-t") 'my-go-to-char)
;;Do What I Mean
(defun qiang-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command. If no region is selected and current line is not blank and we are not at the end of the line, then comment current line. Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
	  (comment-or-uncomment-region (line-beginning-position) (line-end-position))
	(comment-dwim arg)))
(global-set-key "\M-;" 'qiang-comment-dwim-line)

(add-hook 'python-mode-hook
	 (lambda ()
	   (setq indent-tabs-mode t)
	   ;; (whitespace-cleanup-mode 0)
	   (setq tab-width 4)
	   (setq python-indent 4)))
;==========按键=========
(global-set-key [f2] 'linum-mode)
;==========插件==========
(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'color-theme)
(color-theme-initialize)
;(color-theme-dark-laptop)
(color-theme-vim-colors)
;(color-theme-simple-1)
(require 'package)
(setq package-archives '(("gnu"."http://elpa.gnu.org/packages/")
						 ("marmalade". "http://marmalade-repo.org/packages/")
						 ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

;;helm
(require 'helm)
(require 'helm-config)
(require 'helm-eshell)

(add-hook 'eshell-mode-hook
		  #'(lambda ()
			  (define-key eshell-mode-map (kbd "C-c C-l")  'helm-eshell-history)))

(global-set-key (kbd "C-c h") 'helm-command-prefix)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z") 'helm-select-action)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t
	  helm-move-to-line-cycle-in-source     t
	  helm-ff-search-library-in-sexp        t
	  helm-scroll-amount                    8
	  helm-ff-file-name-history-use-recentf t
	  )

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c h o") 'helm-occur)
(setq helm-M-x-fuzzy-match t)
;;(helm-autoresize-mode 1)
(helm-mode 1)

;;window-numbering
(require 'window-numbering)
(setq window-numbering-assign-func
	  (lambda () (when (equal (buffer-name) "*Calculator*") 9)))
(window-numbering-mode 1)

;;highlight-symbol
(require 'highlight-symbol)
(global-set-key (kbd "M--") 'highlight-symbol-at-point)
(global-set-key (kbd "M-n") 'highlight-symbol-next)
(global-set-key (kbd "M-p") 'highlight-symbol-prev)

;;expand-region
(require 'expand-region)
(global-set-key (kbd "M-m") 'er/expand-region)
(global-set-key (kbd "M-s s") 'er/mark-symbol)
(global-set-key (kbd "M-s p") 'er/mark-outside-pairs)
(global-set-key (kbd "M-s P") 'er/mark-inside-pairs)
(global-set-key (kbd "M-s q") 'er/mark-outside-quotes)
(global-set-key (kbd "M-s Q") 'er/mark-inside-quotes)
(global-set-key (kbd "M-s m") 'er/mark-comment)
(global-set-key (kbd "M-s f") 'er/mark-defun)

;;elpy
;(require 'elpy nil t)
;(elpy-enable)

;;yasnippet
;(require 'yasnippet)
;(yas/initialize)
;(yas/load-directory "~/.emacs.d/elpa/yasnippet-20151004.1657/snippets")
;; yasnippet setting
;(yas-global-mode 1)
;(define-key yas-minor-mode-map (kbd "<tab>") nil)
;(define-key yas-minor-mode-map (kbd "TAB") nil)
;; 设置 f3 为 yas 扩展快捷键
;(define-key yas-minor-mode-map (kbd "<f3>") 'yas-expand)

;; auto-complete
(ac-config-default)

;;flymake
;(require 'flymake)
;(autoload 'flymake-find-file-hook "flymake" "" t)
;(add-hook 'find-file-hook 'flymake-find-file-hook)

;;flymake-python-pyflakes
(require 'flymake-python-pyflakes)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
;; (add-hook 'python-mode-hook setq visual-line-mode 0)

;;pyflakes
(autoload 'flymake-find-file-hook "flymake" "" t)
(add-hook 'find-file-hook 'flymake-find-file-hook)
(setq flymake-gui-warnings-enabled nil)
(setq flymake-log-level 0)
(when (load "flymake" t)
  (
   defun flymake-pycheckers-init ()
		 (
		  let*
			 (
			  (
			   temp-file
			   (
				flymake-init-create-temp-buffer-copy
				'flymake-create-temp-inplace
				)
			   )
			  (
			   local-file
			   (
				file-relative-name
				temp-file
				(
				 file-name-directory buffer-file-name
									 )
				)
			   )
			  )
		   (
			list "pyflakes"  (list local-file)
				 )
		   )

		 (add-to-list 'flymake-allowed-file-name-masks
					  '("\\.py\\'" flymake-pycheckers-init))
		 )
  )

;;python-mode
;(require 'python-mode)
;(add-to-list 'auto-mode-alist '("\\.py'" . python-mode))

;; setup jedi
;(jedi:setup)
;(setq jedi:complete-on-dot t)
;(defun my/python-mode-hook ()
;  (add-to-list 'company-backends 'company-jedi))

;(add-hook 'python-mode-hook 'my/python-mode-hook)

;;Ace-Jump-Mode
(autoload
    'ace-jump-mode
	  "ace-jump-mode" t)
(eval-after-load "ace-jump-mode"
    '(ace-jump-mode-enable-mark-sync))

(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;;slime
(add-to-list 'load-path "/usr/share/emacs/site-lisp/slime/")
(setq inferior-lisp-program "/usr/bin/sbcl")
(require 'slime-autoloads)
(slime-setup)
;; (slime-setup '(slime-fancy))
