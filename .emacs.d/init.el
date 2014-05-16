;;; パス
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/auto-install/")
(add-to-list 'load-path "~/.emacs.d/elpa")
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")

;================================================================
;; キーバインド
;================================================================
(define-key global-map "\C-h" 'delete-backward-char) ; 削除
(define-key global-map "\M-?" 'help-for-help)	     ; ヘルプ
;; (define-key global-map "\C-z" 'undo)		     ; undo
(windmove-default-keybindings) ; Shiftと矢印キーで分割ウィンドウを移動
(define-key mode-specific-map "l" 'se/make-summary-buffer) ; summary

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
;; (require 'yasnippet)
;; ;; ~/.emacs.d/にsnippetsというフォルダを作っておきましょう
;; (setq yas-snippet-dirs
;;       '("~/.emacs.d/snippets" ;; 作成するスニペットはここに入る
;;         "~/.emacs.d/elpa/yasnippet-20130218.2229/snippets" ;; 最初から入っていたスニペット(省略可能)
;;         ))
;; (yas-global-mode 1)

;; ;; 単語展開キーバインド (ver8.0から明記しないと機能しない)
;; ;; (setqだとtermなどで干渉問題ありでした)
;; ;; もちろんTAB以外でもOK 例えば "C-;"とか
;; (custom-set-variables '(yas-trigger-key "TAB"))

;; ;; 既存スニペットを挿入する
;; (define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
;; ;; 新規スニペットを作成するバッファを用意する
;; (define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
;; ;; 既存スニペットを閲覧・編集する
;; (define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)

;================================================================
;; indent
;================================================================
;TABの追加 ==> C-q TAB
(add-hook 'c-mode-hook
	  (lambda ()
	    (c-set-style "linux")
	    (setq indent-tabs-mode t)))

;;タブ幅を 8
(setq-default tab-width 8)
;================================================================
;; 表示
;================================================================
;; (display-time)
;;; 行番号・桁番号を表示させる
;(line-number-mode 1)
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
(set-face-background 'trailing-whitespace "#4a4a4a")

;; 現在の関数名を表示
(which-function-mode 1)

;; スタートアップ非表示
(setq inhibit-startup-screen t)


;; 折り返さない
(setq-default truncate-lines t)

;; diffの表示方法を変更
;; (defun diff-mode-setup-faces ()
;;   ;; 追加された行は緑で表示
;;   (set-face-attribute 'diff-added nil
;;                       :foreground "white" :background "dark olive green")
;;   ;; 削除された行は赤で表示
;;   (set-face-attribute 'diff-removed nil
;;                       :foreground "white" :background "PaleVioletRed4")
;;   ;; 文字単位での変更箇所は色を反転して強調
;;   (set-face-attribute 'diff-refine-change nil
;;                       :foreground nil :background nil
;;                       :weight 'bold :inverse-video t))
;; (add-hook 'diff-mode-hook 'diff-mode-setup-faces)

;; ;; diffを表示したらすぐに文字単位での強調表示も行う
;; (defun diff-mode-refine-automatically ()
;;   (diff-auto-refine-mode t))
;; (add-hook 'diff-mode-hook 'diff-mode-refine-automatically)

;; diffの表示方法を変更 その２
(require 'diff-mode)
(set-face-attribute 'diff-added-face nil
		    :background nil :foreground "green"
		    :weight 'normal)
(set-face-attribute 'diff-removed-face nil
		    :background nil :foreground "red"
		    :weight 'normal)

(set-face-attribute 'diff-file-header-face nil
		    :background nil :weight 'extra-bold)

(set-face-attribute 'diff-hunk-header-face nil
		    :foreground "chocolate4"
		    :background "white" :weight 'extra-bold
		    :underline t :inherit nil)

;; タイトルバーにファイルのフルパス表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;================================================================
;; misc
;================================================================
(autoload 'se/make-summary-buffer "summarye" nil t) ;関数一覧表示
;;(require 'magit)
(require 'ag)
(setq ag-reuse-buffers 't)

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
;(require 'auto-complete)
;(global-auto-complete-mode t)

;; 履歴を次回Emacs起動時にも保存する
(savehist-mode 1)

;;; ファイル内のカーソル位置を記憶する
(setq-default save-place t)
(require 'saveplace)

;; diredから"r"でファイル名をインライン編集する
(require 'dired-x)
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; file名の補完で大文字小文字を区別しない
(setq completion-ignore-case t)

;; バッファ自動再読み込み
(global-auto-revert-mode 1)
(setq auto-revert-interval 1)

;; シンボリックリンクの読み込みを許可
(setq vc-follow-symlinks t)
;; シンボリックリンク先のVCS内で更新が入った場合にバッファを自動更新
(setq auto-revert-check-vc-info t)

(require 'moccur-edit)

;; popwin
;; (require 'popwin)
;; (setq display-buffer-function 'popwin:display-buffer)
;; (setq anything-samewindow nil)
;; (push '("*anything*" :height 20) popwin:special-display-config)
;; (push '(" *auto-async-byte-compile*" :position bottom :noselect t) popwin:special-display-config)
;; (global-set-key (kbd "C-z") popwin:keymap)           ; popwin

;(require 'popwin)
;(popwin-mode 1)

;(setq display-buffer-function 'popwin:display-buffer)
;(setq popwin:popup-window-position 'bottom)

;; M-x anything
;(setq anything-samewindow nil)
;(push '("*anything*" :height 20) popwin:special-display-config)

;; M-x dired-jump-other-window
;(push '(dired-mode :position top :height 40) popwin:special-display-config)


;; M-!
;(push '("*Shell Command Output*" :height 40) popwin:special-display-config)

;; cscope
;;(push "*cscope*" popwin:special-display-config)

;;(push '("*grep*" :position top :height 40) popwin:special-display-config)
;;(push '("*grep*" :noselect t) popwin:special-display-config)

;; M-x compile
;(push '(compilation-mode :noselect t) popwin:special-display-config)

;(push '("*byte-compile*" :noselect t) popwin:special-display-config)

;(global-set-key (kbd "C-z") popwin:keymap)
;; Keymap:
;; | Key    | Command                               |
;; |--------+---------------------------------------|
;; | b      | popwin:popup-buffer                   |
;; | l      | popwin:popup-last-buffer              |
;; | o      | popwin:display-buffer                 |
;; | C-b    | popwin:switch-to-last-buffer          |
;; | C-p    | popwin:original-pop-to-last-buffer    |
;; | C-o    | popwin:original-display-last-buffer   |
;; | SPC    | popwin:select-popup-window            |
;; | s      | popwin:stick-popup-window             |
;; | 0      | popwin:close-popup-window             |
;; | f, C-f | popwin:find-file                      |
;; | e      | popwin:messages                       |
;; | C-u    | popwin:universal-display              |
;; | 1      | popwin:one-window                     |



;; 　拡張子とメジャーモードの関連付け
(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.mak$" . makefile-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . makefile-mode))
(add-to-list 'auto-mode-alist '("\\.dtsi$" . c-mode))
(add-to-list 'auto-mode-alist '("\\.dts$" . c-mode))


;; マークダウン

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
;; (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.txt\\'" . markdown-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (deeper-blue)))
 '(default-frame-alist (quote ((height . 70) (width . 120))))
 '(markdown-command "/usr/bin/multimarkdown")
 '(markdown-open-command "/opt/google/chrome/chrome"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; Mew を使う為の設定
(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
(setq mew-fcc "+outbox") ; 送信メールを保存
(setq exec-path (cons "/usr/bin" exec-path))

;================================================================
;; 翻訳
;================================================================
(require 'google-translate)
(global-set-key "\C-xt" 'google-translate-at-point)         ; en -> ja
(global-set-key "\C-xT" 'google-translate-at-point-reverse) ; ja -> en
;; 翻訳のデフォルト値を設定（en -> ja）
(custom-set-variables
  '(google-translate-default-source-language "en")
  '(google-translate-default-target-language "ja"))

;; popwin.el
;;;;(require 'popwin)
;; おまじない（よく分かってない、、）
;;;;(setq display-buffer-function 'popwin:display-buffer)
;; ポップアップを画面下に表示
;;;;(setq popwin:popup-window-position 'bottom)

;; google-translate.elの翻訳バッファをポップアップで表示させる
;;;;(push '("*Google Translate*") popwin:special-display-config)

;; スペルチェック
;; (setq-default ispell-program-name "aspell")
;; (setq ispell-grep-command "grep")
;; (eval-after-load "ispell"
;;  '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
;; (setq flyspell-issue-welcome-flag nil)


;================================================================
;; tmux風　rotate window
;================================================================
(require 'rotate)
(global-set-key (kbd "C-t") 'rotate-layout)
(global-set-key (kbd "M-t") 'rotate-window)


;================================================================
;; Emacs の種類バージョンを判別するための変数を定義
;================================================================
;; @see http://github.com/elim/dotemacs/blob/master/init.el
;(defun x->bool (elt) (not (not elt))
;(defvar emacs23-p (equal emacs-major-version 23))
;(defvar emacs24-p (equal emacs-major-version 24))
;(defvar linux-p (eq system-type 'gnu/linux))

(when (eq system-type 'gnu/linux)
  (require 'mozc)
  (set-language-environment "Japanese")
  (setq default-input-method "japanese-mozc")
  ;;(global-set-key (kbd "M-`") 'toggle-input-method)
  ;; (global-set-key [?\S-\ ] 'toggle-input-method) ;; shift + space
  (global-set-key (kbd "C-o") 'toggle-input-method)
  (set-frame-font "Monaco-8") ;; フォント linux ;
  (prefer-coding-system 'utf-8-unix)
  (set-locale-environment "en_US.UTF-8") ; "ja_JP.UTF-8"
  (set-default-coding-systems 'utf-8-unix)
  (set-selection-coding-system 'utf-8-unix)
  (set-buffer-file-coding-system 'utf-8-unix)
  ;;起動時のフレームサイズを設定する
  (setq initial-frame-alist
	(append (list
		 '(width . 160)
		 '(height . 54)
		 )
		initial-frame-alist))
  )

(when (eq system-type 'windows-nt)
  (set-frame-font "ＭＳ ゴシック-9")
  (setq file-name-coding-system 'sjis)
  (setq locale-coding-system 'sjis)
  ;;起動時のフレームサイズを設定する
  (setq initial-frame-alist
	(append (list
		 '(width . 100)
		 '(height . 50)
		 )
		initial-frame-alist))
  (setq default-frame-alist initial-frame-alist))

(if window-system
    (progn
      (auto-image-file-mode t) ;; 画像ファイルを表示
      (cua-mode t) ;; cua-mode 矩形選択 C-RETで起動 M-x cua-modeでenabledにする
      (setq cua-enable-cua-keys nil) ;; 変なキーバインド禁止
      (setq x-select-enable-clipboard t); クリップボードとキルリングを同期させる
      ;; (set-frame-parameter (selected-frame) 'alpha '(0.90)) ;; フレームの透明度
      (tool-bar-mode 0) ;;; メニューバー、スクロールバーを消す
      (menu-bar-mode 0) ;;; メニューバー、スクロールバーを消す
      (toggle-scroll-bar nil)
      (require 'color-theme)
      (color-theme-initialize)
      (color-theme-dark-laptop)
      ;; (require 'color-theme-tangotango)
      ;; (require 'color-theme-wombat)
      ;;(color-theme-wombat)
      ;; (color-theme-sanityinc-tomorrow-night)
      ;; カーソル行をハイライトする
      (defface hlline-face
	'((((class color)
	    (background dark))
	   (:background "gray25"))
	  (((class color)
	    (background light))
	   (:background "blue"))
	  (t
	   ()))
	"*Face used by hl-line.")
      (setq hl-line-face 'hlline-face)
      ;;(setq hl-line-face 'underline)
      (set-face-background 'region "medium blue")
      (global-hl-line-mode)

      ;; 最近使ったファイル一覧を表示
      (setq recentf-max-saved-items 5000)
      (setq recentf-exclude '("/TAGS$" "/var/tmp/"))
      (require 'recentf-ext)
      (global-set-key (kbd "C-@") 'recentf-open-files)
      ))

;; 多重起動の防止
(require 'server)
(unless (server-running-p)
  (server-start))
