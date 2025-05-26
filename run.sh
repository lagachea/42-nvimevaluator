#!/bin/sh
BASE=$(readlink -f $0 | xargs dirname)
APPBIN=$BASE/nvim-linux-x86_64/bin/nvim
[ ! -f $APPBIN ] && printf "neovim not installed\nInstalling" && ./install.sh

APPNAME="tmp-nvim"

alias 42vim="NVIM_APPNAME=$APPNAME $APPBIN"
