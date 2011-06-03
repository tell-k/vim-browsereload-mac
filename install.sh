#!/bin/sh

wget https://github.com/tell-k/vim-browsereload-mac/tarball/master -O browsereload-mac-vim.tar.gz
tar xvzf browsereload-mac-vim.tar.gz
mv tell-k-vim-browsereload-mac-* browsereload-mac-vim
cp -pr ./browsereload-mac-vim/plugin/browsereload-mac.vim ~/.vim/plugin/ 
