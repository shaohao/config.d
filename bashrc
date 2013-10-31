#
# bashrc preset
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
[[ -f /etc/profile ]] && . /etc/profile

# Configuration files
for conf in ${BASH_SOURCE[0]%/*}/bash.conf.d/*; do
	[[ -r $conf ]] && . $conf
done
unset conf

# ex: ts=4 sw=4 ft=sh
