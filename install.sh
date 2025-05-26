#!/bin/sh

./neovim.sh
APPNAME="tmp-nvim"

CONFIG="config"
SHARE="share"
STATE="state"
CACHE="cache"

# local
./choose-config.sh
mkdir -p $SHARE
mkdir -p $STATE
mkdir -p $CACHE


SYSTEM_CONFIG="$HOME/.config/$APPNAME"
SYSTEM_DATA="$HOME/.local/share/$APPNAME"
SYSTEM_STATE="$HOME/.local/state/$APPNAME"
SYSTEM_CACHE="$HOME/.cache/$APPNAME"

#link local into home
ln -sr $CONFIG $SYSTEM_CONFIG
ln -sr $SHARE $SYSTEM_DATA
ln -sr $STATE $SYSTEM_STATE
ln -sr $CACHE $SYSTEM_CACHE
