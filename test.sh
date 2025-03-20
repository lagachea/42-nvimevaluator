#!/bin/sh

XDG_CONFIG_HOME=".config"
XDG_DATA_HOME=".local/share"
XDG_STATE_HOME=".local/state"
XDG_CACHE_HOME=".cache"

mkdir -p $XDG_CONFIG_HOME
mkdir -p $XDG_DATA_HOME
mkdir -p $XDG_STATE_HOME
mkdir -p $XDG_CACHE_HOME

export XDG_CONFIG_HOME
export XDG_DATA_HOME
export XDG_STATE_HOME
export XDG_CACHE_HOME

APPNAME=tmp-nvim
APPBIN=./nvim-linux-x86_64/bin/nvim

ln -s ../config .config/$APPNAME
NVIM_APPNAME=$APPNAME $APPBIN
