#!/bin/sh

APPNAME=tmp-nvim

SYSTEM_CONFIG="$HOME/.config/$APPNAME"
SYSTEM_DATA="$HOME/.local/share/$APPNAME"
SYSTEM_STATE="$HOME/.local/state/$APPNAME"
SYSTEM_CACHE="$HOME/.cache/$APPNAME"

rm -rf $SYSTEM_CONFIG $SYSTEM_DATA $SYSTEM_STATE $SYSTEM_CACHE

CONFIG="config"
SHARE="share"
STATE="state"
CACHE=".cache"

rm -rf $CONFIG $DATA $STATE $CACHE
rm -rf nvim-linux-x86_64/
