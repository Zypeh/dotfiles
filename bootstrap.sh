#! /usr/bin/env bash

if [ "$HOME" != "$(pwd)" ]; then
	echo "Run the script from your home directory."
	exit 1
fi


config=${XDG_CONFIG_HOME:-~/.config}

# bash shell related
ln -sf $config/bash/'bashrc' '.bashrc'

# mksh shell related
ln -sf $config/mksh/'mkshrc' '.mkshrc'
ln -sf $config/mksh/'profile' '.profile'

# tmux related
ln -sf $config/tmux/'tmux.conf' '.tmux.conf'

# git related
ln -sf $config/git/'gitconfig' '.gitconfig'

# user scripts
ln -sf $config/scripts 'scripts'

# X11 related
ln -sf $config/x11/'xsession' '.xsession'
ln -sf $config/x11/'Xdefaults' '.Xdefaults'

