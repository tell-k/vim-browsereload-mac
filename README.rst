========================
browsereload-mac.vim
========================

Author: tell-k <https://twitter.com/tell_k>
Last Change: 01-Jun-2011.
Version: 1.0.0
WebPage: https://github.com/tell-k/vim-browsereload-mac.vim
License: BSD

Description
--------------------

vim plugin to reflesh your browser. works only MacOS

Required
--------------------

osascript(AppleScript command)

Installation
--------------------

::

 wget
 cp -pr ./plugin/browsereload-mac.vim ~/.vim/plugin/

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
if you wan to change fourcus application, change variables "g:returnApps" to your appliation

::

 "change this variables
 let g:returnApp = "Terminal" 

