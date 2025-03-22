#!/bin/sh

APPBIN=./nvim-linux-x86_64/bin/nvim
[ ! -f $APPBIN ] && printf "neovim not installed\nInstalling" && ./install.sh

BASE=$(readlink -f $0 | xargs dirname)
XDG_CONFIG_HOME="$BASE/.config"
XDG_DATA_HOME="$BASE/.local/share"
XDG_STATE_HOME="$BASE/.local/state"
XDG_CACHE_HOME="$BASE/.cache"

export XDG_CONFIG_HOME
export XDG_DATA_HOME
export XDG_STATE_HOME
export XDG_CACHE_HOME

APPNAME=tmp-nvim
APPBIN=./nvim-linux-x86_64/bin/nvim

NVIM_APPNAME=$APPNAME $APPBIN
