#!/bin/sh

XDG_CONFIG_HOME=".config"
XDG_DATA_HOME=".local/share"
XDG_STATE_HOME=".local/state"
XDG_CACHE_HOME=".cache"

mkdir -p $XDG_CONFIG_HOME
mkdir -p $XDG_DATA_HOME
mkdir -p $XDG_STATE_HOME
mkdir -p $XDG_CACHE_HOME

./neovim.sh
./choose-config.sh
