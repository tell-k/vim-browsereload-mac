"=========================================================
" File:        browsereload-mac.vim
" Author:      tell-k <ffk2005[at]gmail.com>
" Last Change: 03-Jun-2011.
" Version:     1.0.1
" WebPage:     https://github.com/tell-k/vim-browsereload-mac
" License:     BSD
"==========================================================
" see also README.rst

" {{{ Global variables
"
" forcused application enabled 1:True 0:False
if !exists('g:returnAppFlag')
  let g:returnAppFlag = 1
endif 

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

func! s:Reload(app, ...)
    let l:appcmd    = "silent !osascript -e 'tell app \"" . a:app . "\" to activate'"

    if a:0
        let l:reloadcmd = " -e '" . a:1 . "'"
    else
        let l:reloadcmd = g:defaultReloadCmd
    endif

    let l:returncmd = " -e 'tell app \"" . g:returnApp . "\" to activate'"
    let l:devnull = g:debugMode ? " " : "> /dev/null 2>&1"

    if g:returnAppFlag
        exec l:appcmd . l:reloadcmd . l:returncmd . l:devnull
    else
        exec l:appcmd . l:reloadcmd . l:devnull
    endif 

endfunc

" }}}

" {{{ setting Google Chrome 

command! -bar ChromeReload call s:Reload("Google Chrome", 'tell application "Google Chrome" to reload active tab of window 1') 
command! -bar ChromeReloadStart ChromeReloadStop | autocmd BufWritePost <buffer> ChromeReload
command! -bar ChromeReloadStop autocmd! BufWritePost <buffer>

" }}}
" {{{ setting Firefox

command! -bar FirefoxReload call s:Reload("Firefox")
command! -bar FirefoxReloadStart FirefoxReloadStop | autocmd BufWritePost <buffer> FirefoxReload
command! -bar FirefoxReloadStop autocmd! BufWritePost <buffer>

" }}}
" {{{ setting Safari

command! -bar SafariReload call s:Reload("Safari")
command! -bar SafariReloadStart SafariReloadStop | autocmd BufWritePost <buffer> SafariReload
command! -bar SafariReloadStop autocmd! BufWritePost <buffer>

" }}}
" {{{ setting Opera

command! -bar OperaReload call s:Reload("Opera")
command! -bar OperaReloadStart OperaReloadStop | autocmd BufWritePost <buffer> OperaReload
command! -bar OperaReloadStop autocmd! BufWritePost <buffer>

" }}}
" {{{ setting all browser. reload at the same time

command! -bar AllBrowserReload silent OperaReload | SafariReload | FirefoxReload | ChromeReload 
command! -bar AllBrowserReloadStart AllBrowserReloadStop | autocmd BufWritePost <buffer> AllBrowserReload
command! -bar AllBrowserReloadStop autocmd! BufWritePost <buffer>

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

 wget https://github.com/tell-k/vim-browsereload-mac/tarball/master -O browsereload-mac-vim.tar.gz
 tar xvzf browsereload-mac-vim.tar.gz
 mv tell-k-vim-browsereload-mac-* browsereload-mac-vim
 cp -pr ./browsereload-mac-vim/plugin/browsereload-mac.vim ~/.vim/plugin/ 

see also install.sh

Usage
--------------------

browser reload::

 :ChromeReload      //reload "Google Chrome"
 :FirefoxReload     //reload "Firefox"
 :SafariReload      //reload "Safari"
 :OperaReload       //reload "Opera"
 :AllBrowserReload  //reload all browser

start auto reload::

 :ChromeReloadStart  
 :FirefoxReloadStart  
 :SafariReloadStart  
 :OperaReloadStart  
 :AllBrowserReloadStart  

stop auto reload::

 :ChromeReloadStop
 :FirefoxReloadStop
 :SafariReloadStop
 :OperaReloadStop
 :AllBrowserReloadStart


Settings
--------------------

after reload browser. forcus "Terminal" apps.

if you want to change fourcus application, 
change variables "g:returnApps" to your appliation.

::

 "change this variables
 let g:returnApp = "Terminal" 

if you want to stop returnApp, 
change variables "g:returnAppFlag" to 0

::

 "default is 1
 let g:returnAppFlag = 0

if you want old style commad, 
write this setting in your .vimrc

::

 "reload
 command! -bar Cr silent ChromeReload
 command! -bar Fr silent FirefoxReload
 command! -bar Sr silent SafariReload
 command! -bar Or silent OperaReload
 command! -bar Ar silent AllBrowserReload
 "auto reload start
 command! -bar CrStart silent ChromeReloadStart
 command! -bar FrStart silent FirefoxReloadStart
 command! -bar SrStart silent SafariReloadStart
 command! -bar OrStart silent OperaReloadStart
 command! -bar ArStart silent AllBrowserReloadStart
 "auto reload stop
 command! -bar CrStop silent ChromeReloadStop
 command! -bar FrStop silent FirefoxReloadStop
 command! -bar SrStop silent SafariReloadStop
 command! -bar OrStop silent OperaReloadStop
 command! -bar ArStop silent AllBrowserReloadStop

" }}}
