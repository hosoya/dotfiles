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

#source ~/.zsh.d/git-completion.bash
#source ~/.zsh.d/git-completion.zsh

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

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr "*"
zstyle ':vcs_info:*' stagedstr "+"
zstyle ':vcs_info:*' formats "%c%u%r@%b"
zstyle ':vcs_info:*' formats "%c%u%b"
zstyle ':vcs_info:*' actionformats "%c%u%r@%b|%a"

#### option, limit
setopt autocd
setopt automenu
setopt autolist
setopt correct
setopt nobeep
setopt nonomatch
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

#### Terminal title
function _update_terminal_title () {
  #echo "_update_terminal_title"
}
add-zsh-hook precmd _update_terminal_title

#### prompt
function _update_vcs_info_msg () {

  psvar=()
  LANG=en_US.UTF-8 vcs_info
  if [ -n "${vcs_info_msg_0_}" ]
  then
    local stashcnt changes changes_chars
    stashcnt=$(git stash list 2>/dev/null | wc -l | tr -d ' ')
    changes=$(echo ${vcs_info_msg_0_} | sed 's/^\([+\*]\).\+$/\1/')

    case "v${changes}" in
      'v*')
        psvar[2]="2"
        changes_char=""
        ;;
      'v+')
        psvar[3]="3"
        changes_char=""
        ;;
      *)
        changes_char=" "
        ;;
    esac

    changes_char=" "

    if [ ${stashcnt} -gt 0 ]
    then
      psvar[1]="${changes_char}${vcs_info_msg_0_}+${stashcnt}"
    else
      psvar[1]="${changes_char}${vcs_info_msg_0_}"
    fi
  fi
}

add-zsh-hook precmd _update_vcs_info_msg

PROMPT=%F{cyan}"${DIST}"%B%F{magenta}'[%n@%M]%f%b %# '%f
RPROMPT=" %F{yellow}%~ %1(v|%F{green}%2(v|%B%F{red}|)%3(v|%B%F{yellow}|)%1v|)%b%f"


#### history
HISTFILE="${HOME}/.zshistory"
HISTSIZE=100000
SAVEHIST=50000

#### bindkey
bindkey -e

#### alias
alias ls='ls -F -v --color'
alias la='ls -la -h --time-style=long-iso'
alias ll='ls -l -h --time-style=long-iso'
alias l.='ls -d .*'

#### function
#function chpwd() { ls }

#### general export
# export LANG=ja_JP.UTF-8
export EDITOR=emacsclient 
export PAGER='less -r'
export WORDCHARS='*?_-[]~=&;!#$%^(){}<>'


#### shortcut ####
#alias -s {png,jpg,bmp,PNG,JPG,BMP}=eom
alias -s {png,jpg,bmp,PNG,JPG,BMP}=google-chrome
alias -s {html,htm,pdf}=google-chrome

