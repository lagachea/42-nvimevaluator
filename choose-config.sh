#!/bin/bash

ASTRO="https://github.com/AstroNvim/AstroNvim"
CHAD="https://github.com/NvChad/NvChad"
LAZY="https://github.com/LazyVim/LazyVim"
LUNAR="https://github.com/LunarVim/LunarVim"
# LVIM="https://github.com/lvim-tech/lvim"

NAMES=("AstroNvim: an" "NvChad: nv" "LazyVim: lz" "LunarVim: lv")

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


	*)
		printf "no config found\n"
		exit 0
		;;
esac

rm -rf config
if [ ! -z "$SELECTED" -a "$SELECTED" != " " ]; then
	git clone $SELECTED config
fi
