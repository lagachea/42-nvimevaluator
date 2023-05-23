#!/bin/bash

ASTRO="https://github.com/AstroNvim/AstroNvim"
CHAD="https://github.com/NvChad/NvChad"
LAZY="https://github.com/LazyVim/LazyVim"
LUNAR="https://github.com/LunarVim/LunarVim"
DEFAULT="https://gitlab.com/3rdn4x3l4/nvim-conf.git"
NAMES=("AstroNvim: an" "NvChad: nv" "LazyVim: lz" "LunarVim: lv" "alagache: al")

for i in "${NAMES[@]}"
do
	echo "$i"
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


	al)
		printf "config $DEFAULT found\n"
		SELECTED=$DEFAULT
		;;

	*)
		printf "no config found\n"
		exit 0
		;;
esac

rm -rf config
if [ ! -z "$SELECTED" -a "$SELECTED" != " " ]; then
	git clone $SELECTED config
fi
