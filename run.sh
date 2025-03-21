#!/bin/sh

APPBIN=./nvim-linux-x86_64/bin/nvim
[ ! -f $APPBIN ] && printf "neovim not installed\nInstalling" ./neovim.sh

XDG_CONFIG_HOME=".config"
XDG_DATA_HOME=".local/share"
XDG_STATE_HOME=".local/state"
XDG_CACHE_HOME=".cache"

export XDG_CONFIG_HOME
export XDG_DATA_HOME
export XDG_STATE_HOME
export XDG_CACHE_HOME

APPNAME=tmp-nvim
APPBIN=./nvim-linux-x86_64/bin/nvim

NVIM_APPNAME=$APPNAME $APPBIN
