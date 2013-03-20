;;; パス
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/elpa")
(add-to-list 'load-path "~/.emacs.d/helm")

(add-hook 'c-mode-hook
	  '(lambda()
	     (c-set-style "bsd")
	     (setq c-basic-offset 8)
	     (setq tab-width c-basic-offset)
	     (setq indent-tabs-mode t)))

(setq ruby-deep-indent-paren-style nil)


;=============================================================
;; 24
;=============================================================
(global-set-key (kbd “C-x C-b”) ‘ibuffer)
(autoload ‘ibuffer “ibuffer” “List buffers.” t)

;=============================================================
;; キーバインド
;=============================================================
(define-key global-map "\C-h" 'delete-backward-char) ; 削除
(define-key global-map "\M-?" 'help-for-help)	     ; ヘルプ
(define-key global-map "\C-z" 'undo)		     ; undo

;;; anytihng-el
;(require 'anything-startup)
(require 'helm-config)
(require 'helm-command)
;(require 'helm-descbinds)
(helm-mode 1)

;=============================================================
;; mozc 日本語入力
;=============================================================
;(require 'mozc)
;(set-language-environment "Japanese")
;(setq default-input-method "japanese-mozc")
;(global-set-key (kbd "M-`") 'toggle-input-method)


;=============================================================
;; 言語/文字コード
;=============================================================
(prefer-coding-system 'utf-8-unix)
;(set-language-environment "Japanese")
(set-locale-environment "en_US.UTF-8") ; "ja_JP.UTF-8"
(set-default-coding-systems 'utf-8-unix)
(set-selection-coding-system 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)

;=============================================================
;; 表示
;=============================================================
(display-time)
;;; 行番号・桁番号を表示させる
(line-number-mode 1)
(column-number-mode 1)
;;; 行番号を左に表示
(require 'linum)
(global-linum-mode t)	   ; デフォルトで linum-mode を有効にす
;;タブ幅を 8 に設定
(setq-default tab-width 8)

;;;; ツールバーとメニューバーを消す, ;; スクロールバーを消す
(tool-bar-mode -1)
;(menu-bar-mode -1)
(toggle-scroll-bar nil)

;;; 対応する括弧を表示させる
(show-paren-mode 1)

;; 画像ファイルを表示
(auto-image-file-mode t)

;; カーソルの点滅を止める
(blink-cursor-mode 0)

;; ediffを1ウィンドウで実行
;(setq ediff-window-setup-function 'ediff-setup-windows-plain)
;; diffのオプション
;(setq diff-switches '("-u" "-p" "-N"))

;; 行末の空白を強調表示
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "#b14770")

;; フォント Linux
;(set-frame-font "Ricty-11")
;(set-frame-font "Monaco-10", nil t)

;; フレームの透明度
(set-frame-parameter (selected-frame) 'alpha '(0.90))

;; 現在の関数名を表示
(which-function-mode 1)

;; スタートアップ非表示
(setq inhibit-startup-screen t)

;; setting for diff-mode
(require 'diff-mode)

(set-face-attribute 'diff-added-face nil
		    :background nil :foreground "green"
		    :weight 'normal)
(set-face-attribute 'diff-removed-face nil
		    :background nil :foreground "firebrick1"
		    :weight 'normal)

(set-face-attribute 'diff-file-header-face nil
		    :background nil :weight 'extra-bold)

(set-face-attribute 'diff-hunk-header-face nil
		    :foreground "chocolate4"
		    :background "white" :weight 'extra-bold
		    :underline t :inherit nil)

;============================================================
;; misc
;============================================================
;; cua-mode 矩形選択 C-RETで起動 M-x cua-modeでenabledにする
;; http://e-arrows.sakura.ne.jp/2010/02/vim-to-emacs.html
(cua-mode t)
(setq cua-enable-cua-keys nil) ;; 変なキーバインド禁止

;; タイトルバーにファイルのフルパス表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;CSCOPE
(require 'xcscope)

;フレーム版
(require 'sr-speedbar)

;;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
;;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)

;; Ctl + Mouse左ボタン  buffer menu ポップアップを無効
(global-unset-key [\C-down-mouse-1])

;;; yesと入力するのは面倒なのでｙで十分;
(defalias 'yes-or-no-p 'y-or-n-p)

;;; ファイル名がかぶった場合にバッファ名をわかりやすくする
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;auto-complete
;(require 'auto-complete)
;(global-auto-complete-mode t)

;; 履歴を次回Emacs起動時にも保存する
(savehist-mode 1)
;;; ファイル内のカーソル位置を記憶する
(setq-default save-place t)
(require 'saveplace)

; クリップボードとキルリングを同期させる
(cond (window-system
       (setq x-select-enable-clipboard t)
       ))

;; diredから"r"でファイル名をインライン編集する
(require 'dired-x)
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;;;多重起動の防止
(server-start)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (deeper-blue))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
