#!/bin/bash

ASTRO="https://github.com/AstroNvim/AstroNvim"
CHAD="https://github.com/NvChad/NvChad"
LAZY="https://github.com/LazyVim/LazyVim"
LUNAR="https://github.com/LunarVim/LunarVim"
KICKSTART="https://github.com/nvim-lua/kickstart.nvim"
DEFAULT="https://gitlab.com/3rdn4x3l4/nvim-conf.git"
NAMES=("AstroNvim: an"
	"NvChad: nv"
	"LazyVim: lz"
	"LunarVim: lv"
	"kickstart: ks"
	"alagache: al")

for i in "${NAMES[@]}"
do
	printf "$i\n"
done

echo -n "Enter the short name of a config [xx]: "
read CONFIG

SELECTED=""

case $CONFIG in
	an)
		printf "config $ASTRO found\n"
		SELECTED=$ASTRO
		;;

	nv)
		printf "config $CHAD found\n"
		SELECTED=$CHAD
		;;

	lz)
		printf "config $LAZY found\n"
		SELECTED=$LAZY
		;;

	lv)
		printf "config $LUNAR found\n"
		SELECTED=$LUNAR
		;;

	ks)
		printf "config $KICKSTART found\n"
		SELECTED=$KICKSTART
		;;

	al)
		printf "config $DEFAULT found\n"
		SELECTED=$DEFAULT
		;;

	*)
		printf "no config found defaults to kickstart\n"
		SELECTED=$KICKSTART
		;;
esac

if [ ! -z "$SELECTED" -a "$SELECTED" != " " ]; then
	rm -rf config
	git clone $SELECTED config
fi
