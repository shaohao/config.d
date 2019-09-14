#!/bin/sh

cfm=$1

_inst_cfg() {
	if [ x"$cfm" != x"-y" ]; then
		read -p "Install $1 configurations? [Y/n] " ans
		test "$ans" = "" || test "$ans" = "y" || test "$ans" = "Y"
	fi
}

if _inst_cfg bash; then
	cat <<EOC
Paste below content into your own bashrc file:
test -r "$PWD/bashrc" && . "$PWD/bashrc"
EOC
fi

if _inst_cfg zsh ; then
	cat <<EOC
Paste below content into your own zshrc file:
test -r "$PWD/zshrc" && . "$PWD/zshrc"
EOC
	ln -sfvT $PWD/oh-my-zsh $HOME/.oh-my-zsh
fi

if _inst_cfg 'sway+waybar'; then
	ln -sfvT $PWD/sway $HOME/.config/sway
	ln -sfvT $PWD/waybar $HOME/.config/waybar
fi

if _inst_cfg git; then
	ln -sfv $PWD/gitconfig $HOME/.gitconfig
	ln -sfv $PWD/cvsignore $HOME/.cvsignore
	if [ -f /usr/share/git/git-prompt.sh ]; then
		ln -sfv /usr/share/git/git-prompt.sh $HOME/.git-prompt
	elif [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
		ln -sfv /usr/share/git-core/contrib/completion/git-prompt.sh $HOME/.git-prompt
	else
		echo "You need create the $HOME/.git-prompt manually!"
	fi
fi

if _inst_cfg powerline-fonts; then
	ln -sfvT $PWD/fonts $HOME/.local/share/fonts
	fc-cache -fv $HOME/.local/share/fonts
fi

if _inst_cfg termite; then
	ln -sfvT $PWD/termite $HOME/.config/termite
fi

if _inst_cfg tmux ; then
	ln -sfv $PWD/tmux.conf $HOME/.tmux.conf
fi

if _inst_cfg vim ; then
	cp -iv $PWD/vimrc $HOME/.vimrc
	ln -sfvT $PWD/vimfiles $HOME/.vim
fi

if _inst_cfg ctags ; then
	ln -sfv $PWD/ctags $HOME/.ctags
fi

if _inst_cfg vifm; then
	ln -sfv $PWD/vifmrc $HOME/.config/vifm/vifmrc
fi

# ex: ts=4 sw=4 ft=sh
