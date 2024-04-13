# open tmux 
[[ $- != *i* ]] && return
[[ $TERM != "screen" ]] && tmux && exit
#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#

autoload -U compinit
compinit

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

## history
## for sharing history between zsh processes
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.history

#color make everything prettier
autoload -U colors
colors
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
alias ls='ls --color=auto'
alias ll="ls -lah"

#just a fun way to cd
setopt AUTOCD

#autopushd
setopt autopushd

#autocorrect
setopt CORRECT

#vim in the command line sucks
bindkey -e

# bind home, delete, etc keys
# key bindings
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char

#PROMPT
##allow substitution
setopt prompt_subst
autoload -Uz vcs_info
 
#git styling
zstyle ':vcs_info:*' stagedstr '%F{green}●'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git svn

#prompt parts
local git_branch='${vcs_info_msg_0_}'
local return_code='%(0?..%F{red}(%?%)%f)'
local time_str="$fg_bold[grey]%}%w %*%{%f%}"
local timsize=${#${(%):-%w %*%}}

local ASYNC_PROC=0
precmd () {
    # do git asynchronously for faster response
    async () {
        #git info
        if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
                printf "%s" "%F{blue}[%F{green}%b%c%u%F{blue}]%f" > "/tmp/vcs_info_$$"
        } else {
                printf "%s" "%F{blue}[%F{green}%b%c%u%F{red}●%F{blue}]%f" > "/tmp/vcs_info_$$"
        }
        # signal parent
        kill -s USR1 $$
    }

    # kill child if necessary
    if [[ "${ASYNC_PROC}" != 0 ]]; then
        kill -s HUP $ASYNC_PROC >/dev/null 2>&1 || :
    fi
    # start background computation
    async &!
    ASYNC_PROC=$!

	#if dirsize too long, truncate
	local dirsize=${#${(%):-%~}}
	if [[ $dirsize -gt (( $COLUMNS/2 - $timsize/2 - 6 )) ]]; then
		(( dirsize = $COLUMNS/2 - $timsize/2 - 6 ))
	fi
	local current_dir="%B%$dirsize<...<%~%<<%B"

	#first round of spaces to center date
	local PR_FILL1="\${(l.(($COLUMNS/2 - 3 - $dirsize - $timsize/2)).. .)}"

	#ser virtualenv
	local PR_VIRTUAL="`basename \"$VIRTUAL_ENV\"`"

	#setting prompt here because PR_FILL does not get passed
	PROMPT="╭─ %{%F{blue}%}${current_dir}%{%f%}${(e)PR_FILL1}${time_str}${(e)PR_FILL2}%{%f%}
╰─${PR_VIRTUAL} %B%#%b%{%f%} "
	RPROMPT="${return_code} ${git_branch}"
}

TRAPUSR1 () {
    local vcs_info_style="$(cat /tmp/vcs_info_$$)"
    zstyle ':vcs_info:*' formats $vcs_info_style
    vcs_info
	RPROMPT="${return_code} ${git_branch}"
    ASYNC_PROC=0
    zle && zle reset-prompt
}

#env
export EDITOR=vim
export PATH=$PATH:~/imp/prog/depot_tools:~/.rbenv/bin:/opt/Android/Sdk/tools:~/google-cloud-sdk/bin
export SVN_EDITOR=vim

alias vi='vim -v'
alias top='htop'
alias httpdlog='sudo tail -f /var/log/httpd/error_log'
alias cleand='rm -r ~/tmp/downloads/*'
alias untar='tar -xvzf'
alias grep='grep --color=auto'
grr() { grep -ri --color=always --exclude-dir=node_modules --exclude-dir=.git $1 . }
fr() { rg -l $1 | xargs sed -i "" "s/$1/$2/g" }
vig() { vi $(grep -ril $1) }

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

#NPM configuration
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$NPM_PACKAGES/bin:$PATH"
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"


#use fd for fzf
if type "fdfind" > /dev/null; then
	export FZF_DEFAULT_COMMAND='fdfind --type f'
else
	export FZF_DEFAULT_COMMAND='fd --type f'
fi
bindkey '^F' fzf-file-widget

#fzf for git
fbr() {
  local branches branch
  branches=$(git branch -a)
  branch=$(echo "$branches" | fzf +s +m -e)
  zle -U $(echo "$branch" | sed "s:.* remotes/origin/::" | sed "s:.* ::")
}
zle     -N   fbr
bindkey '^Z' fbr

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# vcs jump for vim
export PATH=$PATH:~/.vim/plugged/vcs-jump/bin
alias vimerge="vim -c 'VcsJump merge'"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.fzf_local.zsh ] && source ~/.fzf_local.zsh
[ -f ~/.zshrc_local ] && source ~/.zshrc_local

# Created by `pipx` on 2023-06-26 12:01:55
export PATH="$PATH:/Users/seb.ventura/.local/bin"

# bun completions
[ -s "/Users/seb.ventura/.bun/_bun" ] && source "/Users/seb.ventura/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
