#!/bin/sh

# Nightly build
URL="https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz"

curl -L ${URL} > neovim_tmp.tar.gz;
tar -xf neovim_tmp.tar.gz;
rm -rf neovim_tmp.tar.gz;
