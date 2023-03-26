#!/bin/sh

# Nightly build
URL="https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz"

curl -L ${URL} > neovim_tmp.tar.gz;
tar -xf neovim_tmp.tar.gz;
rm -rf neovim_tmp.tar.gz;
