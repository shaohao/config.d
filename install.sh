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

if _inst_cfg i3-wm; then
	ln -sfvT $PWD/i3 $HOME/.i3
	ln -sfv $PWD/i3/xprofile $HOME/.xprofile
	ln -sfv $PWD/i3/i3status.conf $HOME/.i3status.conf
fi

if _inst_cfg git; then
	ln -sfv $PWD/gitconfig $HOME/.gitconfig
	ln -sfv $PWD/cvsignore $HOME/.cvsignore
	if [ -f /usr/share/git/git-prompt.sh ]; then
		ln -sfv /usr/share/git/git-prompt.sh $PWD/bashrc_personal.d/git-prompt
	elif [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
		ln -sfv /usr/share/git-core/contrib/completion/git-prompt.sh $PWD/bashrc_personal.d/git-prompt
	fi
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

# ex: ts=4 sw=4 ft=sh
