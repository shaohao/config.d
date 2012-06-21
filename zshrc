# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory notify
unsetopt beep

# Function path
fpath=($HOME/.zshrc_personal.d $fpath)
zstyle :compinstall filename '/home/jinxin/.zshrc'
autoload -Uz compinit
compinit

# Menu completion & selection
zstyle ':completion:*' menu select=2

# Prompt
autoload -Uz promptinit
promptinit
prompt adam2

# Personal scripts
if [[ -d $HOME/.zshrc_personal.d ]]; then
	for util in $HOME/.zshrc_personal.d/[^_]*; do
		source $util
	done
	unset util
fi
