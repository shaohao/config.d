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
	ln -sfv $PWD/config/awesome $HOME/.config/awesome
fi

if _inst_cfg rxvt-unicode ; then
	ln -sfv $PWD/Xdefaults $HOME/.Xdefaults
fi

if _inst_cfg vim ; then
	ln -sfv $PWD/vimrc $HOME/.vimrc
	ln -sfvT $PWD/vimfiles $HOME/.vim
fi

if _inst_cfg most ; then
	ln -sfv $PWD/mostrc $HOME/.mostrc
fi

if _inst_cfg mplayer ; then
	ln -sfvT $PWD/mplayer $HOME/.mplayer
fi

# ex: ts=4 sw=4 ft=sh
