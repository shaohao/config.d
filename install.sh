#!/bin/sh

cfm=$1

_inst_cfg() {
	if [ x"$cfm" != x"-y" ]; then
		read -p "Install $1 configurations? [Y/n] " ans
		test "$ans" = "" || test "$ans" = "y" || test "$ans" = "Y"
	fi
}

if _inst_cfg bash; then
	ln -sfv $PWD/bashrc $HOME/.bashrc
	ln -sfvT $PWD/bashrc_personal.d $HOME/.bashrc_personal.d
fi

if _inst_cfg zsh ; then
	ln -sfv $PWD/zshrc $HOME/.zshrc
	ln -sfvT $PWD/zshrc_personal.d $HOME/.zshrc_personal.d
	ln -sfvT $PWD/oh-my-zsh $HOME/.oh-my-zsh
fi

if _inst_cfg awesome ; then
	ln -sfvT $PWD/awesome $HOME/.config/awesome
	ln -sfv $PWD/awesome/xprofile $HOME/.xprofile
fi

if _inst_cfg gnome; then
	ln -sfv $PWD/gnome/xprofile $HOME/.xprofile
fi

if _inst_cfg git; then
	echo "Create symbol link to git and git-prompt.sh manually"
fi

if _inst_cfg rxvt-unicode ; then
	ln -sfv $PWD/Xdefaults $HOME/.Xdefaults
fi

if _inst_cfg tmux ; then
	ln -sfv $PWD/tmux.conf $HOME/.tmux.conf
fi

if _inst_cfg vim ; then
	ln -sfv $PWD/vimrc $HOME/.vimrc
	ln -sfvT $PWD/vimfiles $HOME/.vim
fi

if _inst_cfg ctags ; then
	ln -sfv $PWD/ctags.conf $HOME/.ctags
fi

if _inst_cfg vifm; then
	ln -sfv $PWD/vifmrc $HOME/.vifm/vifmrc
fi

if _inst_cfg most ; then
	ln -sfv $PWD/mostrc $HOME/.mostrc
fi

if _inst_cfg mplayer ; then
	ln -sfvT $PWD/mplayer $HOME/.mplayer
fi

# ex: ts=4 sw=4 ft=sh
