#!/bin/bash

git subtree pull --prefix=vimfiles  https://github.com/shaohao/vimfiles.git        master --squash
git subtree pull --prefix=oh-my-zsh https://github.com/robbyrussell/oh-my-zsh.git master --squash
git subtree pull --prefix=powerline https://github.com/powerline/powerline.git    master --squash

