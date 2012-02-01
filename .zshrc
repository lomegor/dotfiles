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
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history

#color make everything prettier
autoload -U colors
colors

#just a fun way to cd
setopt AUTOCD

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

#precmd used for setting prompt because I could not find a way
#to use data on here on another function
precmd () {
	#git info
	if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
			zstyle ':vcs_info:*' formats '%F{blue}[%F{green}%b%c%u%F{blue}]%f'
	} else {
			zstyle ':vcs_info:*' formats '%F{blue}[%F{green}%b%c%u%F{red}●%F{blue}]%f'
	}
	vcs_info

	#if dirsize too long, truncate
	local dirsize=${#${(%):-%~}}
	if [[ $dirsize -gt (( $COLUMNS/2 - $timsize/2 - 6 )) ]]; then
		(( dirsize = $COLUMNS/2 - $timsize/2 - 6 ))
	fi
	local current_dir="%B%$dirsize<...<%~%<<%B"

	#first round of spaces to center date
	local PR_FILL1="\${(l.(($COLUMNS/2 - 3 - $dirsize - $timsize/2)).. .)}"

	#battery
	#maybe change directories if needed
	#local rem=$(grep "^remaining capacity" /proc/acpi/battery/BAT1/state | awk '{ print $3 }')
	#local full=$(grep "^last full capacity" /proc/acpi/battery/BAT1/info | awk '{ print $4 }')
	#local state=$(grep "^charging state" /proc/acpi/battery/BAT1/state | awk '{ print $3 }')
	local rem=$(cat /sys/class/power_supply/BAT1/charge_now)
	local full=$(cat /sys/class/power_supply/BAT1/charge_full)
	local state=$(cat /sys/class/power_supply/BAT1/status)


	#calculate percentage and color of battery
	local percentage
		(( percentage = ($rem*10/$full)))
	local PR_BATTERY="${(l.$percentage)..█.)}"
	local PR_BATTERY_COLOR="$fg_bold[grey]"
	if [[ percentage -lt 2 ]]; then
		PR_BATTERY_COLOR="%F{red}"
	elif [[ percentage -lt 4 ]]; then 
		PR_BATTERY_COLOR="%F{yellow}"
	fi
	local percsize=$percentage

	#add symbol if chargin
	local charging=""
	if [[ $state != "Discharging" ]]; then
		charging="↯"
		((percsize=percsize+1))
	fi
	#second space round for getting everything to the end of the line
	local PR_FILL2="\${(l.(( ($COLUMNS - 1)/2 - $percsize - $timsize/2)).. .)}"
	PR_BATTERY="${charging}${PR_BATTERY}"

	#setting prompt here because PR_FILL does not get passed
	PROMPT="╭─ %{%F{blue}%}${current_dir}%{%f%}${(e)PR_FILL1}${time_str}${(e)PR_FILL2}${PR_BATTERY_COLOR}${PR_BATTERY}%{%f%}
╰─ %B%#%b%{%f%} "
	RPROMPT="${return_code} ${git_branch}"
}

#env
export EDITOR=vi
export PATH=$PATH:~/imp/prog/google_appengine/:~/imp/prog/depot_tools
export SVN_EDITOR=vi

alias vim='gvim -v'
alias open='xdg-open'
alias install='sudo yum install'
alias update='sudo yum update -y'
