========================
browsereload-mac.vim
========================

Description
--------------------

vim plugin to reflesh your browser. 
this plugin works only MacOS.

Required
--------------------

osascript(AppleScript command)

Installation
--------------------

::

 wget https://github.com/tell-k/vim-browsereload-mac.vim/tarball/master -O browsereload-mac-vim.tar.gz
 tar xvzf browsereload-mac-vim.tar.gz
 mv tell-k-vim-browsereload-mac.vim-* browsereload-mac-vim
 cp -pr ./browsereload-mac-vim/plugin/browsereload-mac.vim ~/.vim/plugin/ 

see install.sh

Usage
--------------------

browser reload::

 :Cr  //reload "Google Chrome"
 :Fr  //reload "Firefox"
 :Sr  //reload "Safari"
 :Or  //reload "Opera"
 :Ar  //reload ubove all browser

start auto reload::

 :CrStart  
 :FrStart  
 :SrStart  
 :OrStart  
 :ArStart  

stop auto reload::

 :CrStop
 :FrStop
 :SrStop
 :OrStop
 :ArStart


Settings
--------------------

after reflesh browser. forcus "Terminal" apps.

if you wan to change fourcus application, 
change variables "g:returnApps" to your appliation.

::

 "change this variables
 let g:returnApp = "Terminal" 

