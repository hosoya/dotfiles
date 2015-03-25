#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#

# source profile like .bashrc
if [ -f /etc/profile ]; then
	source /etc/profile
fi
if [ -f ${HOME}/.zshenv ]; then
  source ${HOME}/.zshenv
fi

export PATH=~/.zsh/diff-highlight:$PATH
fpath=(~/.zsh/completion $fpath)
source ~/.zsh/completion/git-prompt.sh
setopt TRANSIENT_RPROMPT
precmd () {
    RPROMPT=`echo $(__git_ps1 "[%s]")|sed -e s/%/%%/|sed -e s/%%%/%%/|sed -e 's/\\$/\\\\$/'`
}
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_DESCRIBE_STYLE="branch"
GIT_PS1_SHOWCOLORHINTS=0

#### autoload
autoload -Uz add-zsh-hook
autoload -Uz colors
colors

autoload -Uz compinit
compinit -u
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

# この行は現在のパスを表示する設定です。ブランチを表示して色をつける設定とは関係ありません
RPROMPT="%{${fg[cyan]}%}%~ %{${reset_color}%}"

#### option, limit
setopt autocd
#setopt automenu
setopt autolist
setopt correct
setopt nobeep
#setopt nonomatch
setopt hist_save_no_dups
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt share_history
setopt inc_append_history
setopt numeric_glob_sort
setopt prompt_subst
setopt extended_history
setopt print_eight_bit
setopt auto_pushd
setopt pushd_ignore_dups
setopt transient_rprompt  #コマンドの実行直後に右プロンプトが消える

PROMPT=%F{cyan}"${DIST}"%B%F{magenta}'[%n@%M]%f%b %# '%f

#### history
HISTFILE="${HOME}/.zshistory"
HISTSIZE=100000
SAVEHIST=50000

#### bindkey
bindkey -e

#### ignore C-s, C-q
stty stop undef
stty start undef

#### shortcut ####
alias ls='ls -F -v --color'
alias la='ls -la -h --time-style=long-iso'
alias ll='ls -l -h --time-style=long-iso'
alias l.='ls -d .*'
alias pd="pushd"
alias po="popd"
alias x="exit"
if [ -x /usr/bin/colordiff -o -x /usr/local/bin/colordiff ]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi
alias ack=ack-grep
alias tree="tree --charset=C"
alias e="emacsclient -n"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

alias -s {png,jpg,bmp,PNG,JPG,BMP}=chromium-browser
alias -s {html,htm}=chromium-browser

alias -s py=python
alias -s rb=ruby
alias -s pl=perl

function extract() {
    case $1 in
	*.tar.gz|*.tgz) tar xzvf $1;;
	*.tar.xz) tar Jxvf $1;;
	*.zip) unzip $1;;
	*.lzh) lha e $1;;
	*.tar.bz2|*.tbz) tar xjvf $1;;
	*.tar.Z) tar zxvf $1;;
	*.gz) gzip -dc $1;;
	*.bz2) bzip2 -dc $1;;
	*.Z) uncompress $1;;
	*.tar) tar xvf $1;;
	*.arj) unarj $1;;
    esac
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract

#### function
function chpwd() { ls }

function google() {
    local str opt
    if [ $# != 0 ]; then
	for i in $*; do
	    str="$str+$i"
	done
	str=`echo $str | sed 's/^\+//'`
	opt='search?num=50&hl=ja&lr=lang_ja'
	opt="${opt}&q=${str}"
    fi
    w3m http://www.google.co.jp/$opt
}

export LESS="-iMR"
export MANPAGER="less -iMR"

#### general export
# export LANG=ja_JP.UTF-8
export EDITOR=emacsclient
export PAGER="less -iMR"
#export LESS='-R'
export WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

#### tmux自動起動
if [ -z $TMUX ]; then
  if $(tmux has-session); then
    tmux attach
  else
    tmux
  fi
fi

#=============================
# source auto-fu.zsh
#=============================
# if [ -f ~/.auto-fu.zsh ]; then
#     source ~/.auto-fu.zsh
#     function zle-line-init () {
#         auto-fu-init
#     }
#     zle -N zle-line-init
#     zstyle ':completion:*' completer _oldlist _complete
# fi

#export FPATH="$FPATH:/opt/local/share/zsh/site-functions/"
if [ -f /usr/share/autojump/autojump.zsh ]; then
    . /usr/share/autojump/autojump.zsh
fi
