#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
[[ -f /etc/profile ]] && \
	. /etc/profile

[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
	. /usr/share/bash-completion/bash_completion

# Correct minor errors in a cd command
shopt -s cdspell

# Personal scripts
if [ -d $HOME/.bashrc_personal.d ]; then
	for util in $HOME/.bashrc_personal.d/*; do
		if [[ -f $util ]]; then
			. $util
		fi
	done
	unset util
fi

# ex: ts=4 sw=4 ft=sh
