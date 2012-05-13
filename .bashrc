# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi

# User specific aliases and functions
export PATH=$PATH:~/imp/prog/google_appengine/:~/imp/prog/depot_tools

alias vim='gvim -v'
alias open='xdg-open'
export SVN_EDITOR=vi
function cdl { cd $1; ls;}
alias install='sudo yum install'
alias update='sudo yum update -y'

#custmization function
# Fill with minuses

# (this is recalculated every time the prompt is shown in function prompt_command):
fill="--- "
reset_style='\[\033[00m\]'
status_style=$reset_style'\[\033[0;90m\]' # gray color; use 0;37m for lighter color
prompt_style=$reset_style
command_style=$reset_style'\[\033[1;29m\]' # bold black

# Prompt variable:
PS1="$status_style"'$fill \t\n'"$prompt_style"'${debian_chroot:+($debian_chroot)}\u@\h:\W\$'"$command_style "

# Reset color for command output

# (this one is invoked every time before a command is executed):

trap 'echo -ne "\e[0m"' DEBUG

function prompt_command {
# create a $fill of all screen width minus the time string and a space:
let fillsize=${COLUMNS}-9
fill=""
while [ "$fillsize" -gt "0" ]
do
	fill="-${fill}" # fill with underscores to work on
	let fillsize=${fillsize}-1
done


# If this is an xterm set the title to user@host:dir
case "$TERM" in
	xterm*|rxvt*)
		bname=`basename "${PWD/$HOME/~}"`
		echo -ne "\033]0;${bname}: ${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"
		;;
	*)
		;;
esac
}
PROMPT_COMMAND=prompt_command


#monetate
export DEVBOX=dev-sventura-1.monetate.org
source ~/dev/prog/monetate/monetate-frontend/frontend/tools/bash/deployment.bash
