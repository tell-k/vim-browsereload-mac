"=========================================================
" File:        browsereload-mac.vim
" Author:      tell-k <https://twitter.com/tell_k>
" Last Change: 01-Jun-2011.
" Version:     1.0.0
" WebPage:     https://github.com/tell-k/vim-browsereload-mac.vim
" License:     BSD
"==========================================================
" see also README.rst

" {{{ Global Variables

" forcused application name after browser reload
if !exists('g:returnApp')
  let g:returnApp = "Terminal"
endif 

" default  browser reload command
if !exists('g:defaultReloadCmd')
  let g:defaultReloadCmd = " -e 'tell application \"System Events\"'"
\                        . " -e '    if UI elements enabled then'"
\                        . " -e '        key down command'"
\                        . " -e '        keystroke \"r\"'"
\                        . " -e '        key up command'"
\                        . " -e '    end if'"
\                        . " -e 'end tell'"
endif

" display command error
if !exists('g:debugMode')
  let g:debugMode = 0 " 0:debug mode off. 1:debug mode on. 
endif 

" }}}
" {{{ Reload()

func! Reload(app, ...)
    let l:appcmd    = "silent !osascript -e 'tell app \"" . a:app . "\" to activate'"

    if a:0
        let l:reloadcmd = " -e '" . a:1 . "'"
    else
        let l:reloadcmd = g:defaultReloadCmd
    endif

    let l:returncmd = " -e 'tell app \"" . g:returnApp . "\" to activate'"
    let l:devnull = g:debugMode ? " " : "> /dev/null 2>&1"
    exec l:appcmd . l:reloadcmd . l:returncmd . l:devnull
endfunc

" }}}

" {{{ setting Google Chrome 

command! -bar Cr call Reload("Google Chrome", 'tell application "Google Chrome" to reload active tab of window 1') 
command! -bar CrStart CrStop | autocmd BufWritePost <buffer> Cr
command! -bar CrStop autocmd! BufWritePost <buffer>

" }}}
" {{{ setting Firefox

command! -bar Fr call Reload("Firefox")
command! -bar FrStart FrStop | autocmd BufWritePost <buffer> Fr
command! -bar FrStop autocmd! BufWritePost <buffer>

" }}}
" {{{ setting Safari

command! -bar Sr call Reload("Safari")
command! -bar SrStart SrStop | autocmd BufWritePost <buffer> Sr
command! -bar SrStop autocmd! BufWritePost <buffer>

" }}}
" {{{ setting Opera

command! -bar Or call Reload("Opera")
command! -bar OrStart OrStop | autocmd BufWritePost <buffer> Or
command! -bar OrStop autocmd! BufWritePost <buffer>

" }}}
" {{{ setting all browser. reload at the same time

command! -bar Ar silent Or | Sr | Fr | Cr 
command! -bar ArStart ArStop | autocmd BufWritePost <buffer> Ar
command! -bar ArStop autocmd! BufWritePost <buffer>

" }}}

" {{{ README.rst
finish

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

see also install.sh

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

" }}}
