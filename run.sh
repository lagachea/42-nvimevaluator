#!/bin/sh

BASE=$(readlink -f $0 | xargs dirname)
APPBIN=$BASE/nvim-linux-x86_64/bin/nvim
[ ! -f $APPBIN ] && printf "neovim not installed\nInstalling" && ./install.sh

XDG_CONFIG_HOME="$BASE/.config" \
XDG_DATA_HOME="$BASE/.local/share" \
XDG_STATE_HOME="$BASE/.local/state" \
XDG_CACHE_HOME="$BASE/.cache" \
$APPBIN
