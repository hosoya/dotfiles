;;; パス
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/auto-install/")
(add-to-list 'load-path "~/.emacs.d/elpa")

; 言語設定
;(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8-unix)
(setq buffer-file-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
;(setenv "LANG" "ja_JP.UTF-8")


(add-hook 'c-mode-hook
        '(lambda()
                (c-set-style "bsd")
                (setq c-basic-offset 4)
                (setq tab-width c-basic-offset)
                (setq indent-tabs-mode t)))

(setq ruby-deep-indent-paren-style nil)

;;;; ツールバーとメニューバーを消す
(tool-bar-mode -1)
(menu-bar-mode -1)
;; スクロールバーを消す
(toggle-scroll-bar nil)
;; 履歴を次回Emacs起動時にも保存する
(savehist-mode 1)
;;; ファイル内のカーソル位置を記憶する
(setq-default save-place t)
(require 'saveplace)
;;; 対応する括弧を表示させる
(show-paren-mode 1)

; current highlight line
(global-hl-line-mode 1)

;;; キーバインド
(define-key global-map "\C-h" 'delete-backward-char) ; 削除
(define-key global-map "\M-?" 'help-for-help)        ; ヘルプ
(define-key global-map "\C-z" 'undo)                 ; undo

(display-time)
;;; 行番号・桁番号を表示させる
(line-number-mode 1)
(column-number-mode 1)
;;; 行番号を左に表示
(require 'linum)
(global-linum-mode t)      ; デフォルトで linum-mode を有効にする
;;; リージョンに色をつける
(transient-mark-mode 1)
;;;多重起動の防止
(server-start)
;;; おりかえし禁止
(setq truncate-partial-width-windows t)
;;タブ幅を 4 に設定
(setq-default tab-width 4)

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
	(load
	 (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;;;; カラーテーマ
(require 'color-theme)
;(color-theme-arjen)
;(color-theme-classic)
(color-theme-charcoal-black)

;;; yesと入力するのは面倒なのでｙで十分
(defalias 'yes-or-no-p 'y-or-n-p)

;;; ファイル名がかぶった場合にバッファ名をわかりやすくする
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)

;;; moccur 
(require 'moccur-edit)
(setq moccur-split-word t)

;;; anytihng-el
(require 'anything-startup)

; magit
;**(add-to-list 'load-path "~/.emacs.d/elpa/magit-0.8.1")
;**(require 'magit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; diffの表示方法を変更
(defun diff-mode-setup-faces ()
  ;; 追加された行は緑で表示
  (set-face-attribute 'diff-added nil
                      :foreground "white" :background "dark green")
  ;; 削除された行は赤で表示
  (set-face-attribute 'diff-removed nil
                      :foreground "white" :background "dark red")
  ;; 文字単位での変更箇所は色を反転して強調
  (set-face-attribute 'diff-refine-change nil
                      :foreground nil :background nil
                      :weight 'bold :inverse-video t))
(add-hook 'diff-mode-hook 'diff-mode-setup-faces)

;; diffを表示したらすぐに文字単位での強調表示も行う
(defun diff-mode-refine-automatically ()
  (diff-auto-refine-mode t))
(add-hook 'diff-mode-hook 'diff-mode-refine-automatically)

;; diff関連の設定
;**(defun magit-setup-diff ()
  ;; diffを表示しているときに文字単位での変更箇所も強調表示する
  ;; 'allではなくtにすると現在選択中のhunkのみ強調表示する
;**  (setq magit-diff-refine-hunk 'all)
  ;; diff用のfaceを設定する
;**  (diff-mode-setup-faces)
  ;; diffの表示設定が上書きされてしまうのでハイライトを無効にする
;**  (set-face-attribute 'magit-item-highlight nil :inherit nil))
;**(add-hook 'magit-mode-hook 'magit-setup-diff)

;; auto-async-byte-compile.el
(require 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "~/.emacs.d/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

; auto-install
(require 'auto-install)			  
(add-to-list 'load-path "~/.emacs.d/auto-install")
(setq auto-install-directory "~/.emacs.d/auto-install/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

;(add-to-list 'load-path "/usr/share/emacs23/site-lisp/cscope")
;s(add-to-list 'load-path "/usr/share/emacs/site-lisp")
(require 'xcscope)

(require 'sr-speedbar)
