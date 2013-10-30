#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
[[ -f /etc/profile ]] && \
	. /etc/profile

# Correct minor errors in a cd command
shopt -s cdspell

# prset files
if [ -d $HOME/.bash.conf.d ]; then
	for conf in $HOME/.bash.conf.d/*; do
		if [[ -f $conf ]]; then
			. $conf
		fi
	done
	unset conf
fi

if [ -r $HOME/.bash_my ]; then
	. $HOME/.bash_my
fi

# ex: ts=4 sw=4 ft=sh
