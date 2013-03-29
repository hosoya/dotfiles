;;; パス
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/auto-install/")
(add-to-list 'load-path "~/.emacs.d/elpa")

;================================================================
;; キーバインド
;================================================================
(define-key global-map "\C-h" 'delete-backward-char) ; 削除
(define-key global-map "\M-?" 'help-for-help)	     ; ヘルプ
(define-key global-map "\C-z" 'undo)		     ; undo

;================================================================
;; anytihng
;================================================================
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;;; anytihng-el
(require 'anything-startup)

; auto-async-byte-compile.el
(require 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "~/.emacs.d/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

; auto-install
(require 'auto-install)
(add-to-list 'load-path "~/.emacs.d/auto-install")
(setq auto-install-directory "~/.emacs.d/auto-install/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

;================================================================
;; MELPA
;================================================================
(require 'package)

; Add package-archives
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")) ; ついでにmarmaladeも追加

; Initialize
(package-initialize)

; melpa.el
(require 'melpa)

;================================================================
;; yasnippet
;================================================================
;; yasnippetを置いているフォルダにパスを通す
;(add-to-list 'load-path
;             (expand-file-name "~/.emacs.d/elisp/yasnippet"))
(require 'yasnippet)
;; ~/.emacs.d/にsnippetsというフォルダを作っておきましょう
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets" ;; 作成するスニペットはここに入る
        "~/.emacs.d/elpa/yasnippet-20130218.2229/snippets" ;; 最初から入っていたスニペット(省略可能)
        ))
(yas-global-mode 1)

;; 単語展開キーバインド (ver8.0から明記しないと機能しない)
;; (setqだとtermなどで干渉問題ありでした)
;; もちろんTAB以外でもOK 例えば "C-;"とか
(custom-set-variables '(yas-trigger-key "TAB"))

;; 既存スニペットを挿入する
(define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
;; 新規スニペットを作成するバッファを用意する
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
;; 既存スニペットを閲覧・編集する
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)


;================================================================
;; indent
;================================================================
(add-hook 'c-mode-hook
	  '(lambda()
	     (c-set-style "bsd")
	     (setq c-basic-offset 8)
	     (setq tab-width c-basic-offset)
	     (setq indent-tabs-mode t)))

(setq ruby-deep-indent-paren-style nil)

;;タブ幅を 8 に設定
(setq-default tab-width 8)

;================================================================
;; 表示
;================================================================
(display-time)
;;; 行番号・桁番号を表示させる
(line-number-mode 1)
(column-number-mode 1)
;;; 行番号を左に表示
(require 'linum)
(global-linum-mode t)      ; デフォルトで linum-mode を有効にする

;;; 対応する括弧を表示させる
(show-paren-mode 1)

;; カーソルの点滅を止める
(blink-cursor-mode 0)

;; 行末の空白を強調表示
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "#b14770")

;; 現在の関数名を表示
(which-function-mode 1)

;; スタートアップ非表示
(setq inhibit-startup-screen t)

;; diffの表示方法を変更
;===================================================
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

;;起動時のフレームサイズを設定する
(setq initial-frame-alist
      (append (list
	       '(width . 120)
	       '(height . 40)
	       )
	      initial-frame-alist))
(setq default-frame-alist initial-frame-alist)

;================================================================
;; misc
;================================================================
;; タイトルバーにファイルのフルパス表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;CSCOPE
(require 'xcscope)

;フレーム版
(require 'sr-speedbar)

;;; バックアップファイルを作らない
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Ctl + Mouse左ボタン  buffer menu ポップアップを無効
(global-unset-key [\C-down-mouse-1])

;;; yesと入力するのは面倒なのでｙで十分;
(defalias 'yes-or-no-p 'y-or-n-p)

;;; ファイル名がかぶった場合にバッファ名をわかりやすくする
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)

;; 履歴を次回Emacs起動時にも保存する
(savehist-mode 1)

;;; ファイル内のカーソル位置を記憶する
(setq-default save-place t)
(require 'saveplace)

;; diredから"r"でファイル名をインライン編集する
(require 'dired-x)
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; 最近使ったファイル一覧を表示
(setq recentf-max-saved-items 5000)
(setq recentf-exclude '("/TAGS$" "/var/tmp/"))
(require 'recentf-ext)
;(global-set-key (kbd "C-@") 'recentf-open-files)

;; file名の補完で大文字小文字を区別しない
(setq completion-ignore-case t)

;; バッファ自動再読み込み
(global-auto-revert-mode 1)

(require 'moccur-edit)
;================================================================
;; Emacs の種類バージョンを判別するための変数を定義
;; @see http://github.com/elim/dotemacs/blob/master/init.el
;(defun x->bool (elt) (not (not elt))
;(defvar emacs23-p (equal emacs-major-version 23))
;(defvar emacs24-p (equal emacs-major-version 24))
;(defvar linux-p (eq system-type 'gnu/linux))

(when (eq system-type 'gnu/linux)
  (require 'mozc)
  (set-language-environment "Japanese")
  (setq default-input-method "japanese-mozc")
  (global-set-key (kbd "M-`") 'toggle-input-method)
  (set-frame-font "Monaco-10") ;; フォント linux ;
  (prefer-coding-system 'utf-8-unix)
  (set-locale-environment "en_US.UTF-8") ; "ja_JP.UTF-8"
  (set-default-coding-systems 'utf-8-unix)
  (set-selection-coding-system 'utf-8-unix)
  (set-buffer-file-coding-system 'utf-8-unix)
  )

(when (eq system-type 'windows-nt)
  (set-frame-font "ＭＳ ゴシック-9")
  (setq file-name-coding-system 'sjis)
  (setq locale-coding-system 'sjis)
  )

(if window-system
    (progn
      (auto-image-file-mode t) ;; 画像ファイルを表示
      (cua-mode t) ;; cua-mode 矩形選択 C-RETで起動 M-x cua-modeでenabledにする
      (setq cua-enable-cua-keys nil) ;; 変なキーバインド禁止
      (setq x-select-enable-clipboard t); クリップボードとキルリングを同期させる
      (require 'color-theme)
      (require 'color-theme-tangotango)
      (require 'color-theme-wombat)
      (require 'color-theme-sanityinc-tomorrow)
      (set-frame-parameter (selected-frame) 'alpha '(0.90)) ;; フレームの透明度
      (tool-bar-mode -1) ;;; メニューバー、スクロールバーを消す
      (toggle-scroll-bar nil)
      ))

;; 多重起動の防止
(require 'server)
(unless (server-running-p)
  (server-start))
