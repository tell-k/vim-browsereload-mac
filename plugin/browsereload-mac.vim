"=========================================================
" File:        browsereload-mac.vim
" Author:      tell-k <ffk2005[at]gmail.com>
" Last Change: 28-Jun-2013.
" Version:     1.1.0
" WebPage:     https://github.com/tell-k/vim-browsereload-mac
" License:     MIT Licence
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
" {{{ hasVimproc()

function! s:hasVimproc()
  if !exists('s:exists_vimproc')
    try
      call vimproc#version()
      let s:exists_vimproc = 1
    catch
      let s:exists_vimproc = 0
    endtry
  endif
  return s:exists_vimproc
endfunction

" }}}
" {{{ Reload()

func! s:Reload(app, ...)
    let l:appcmd    = "osascript -e 'tell app \"" . a:app . "\" to activate'"
    let l:returncmd = " -e 'tell app \"" . g:returnApp . "\" to activate'"
    let l:devnull = g:debugMode ? " " : "> /dev/null 2>&1"

    if a:0
        let l:reloadcmd = " -e '" . a:1 . "'"
    else
        let l:reloadcmd = g:defaultReloadCmd
    endif

    if g:returnAppFlag
        let l:execcmd = l:appcmd . l:reloadcmd . l:returncmd . l:devnull
    else
        let l:execcmd = l:appcmd . l:reloadcmd . l:devnull
    endif 

    if exists('g:reloadPreHook')
        let l:execcmd = g:reloadPreHook . " && " . l:execcmd
    endif

    if exists('g:reloadPostHook')
        let l:execcmd  = l:execcmd . " && " . g:reloadPostHook
    endif

    if s:hasVimproc()
        let s:tmpfile = tempname()
        call writefile([l:execcmd, "rm -fr " . s:tmpfile], s:tmpfile)
        call vimproc#pgroup_open("sh " . s:tmpfile)
    else
        exec "silent !" . l:execcmd
    endif

    " Force redraw the calling VIM window, incase it doesn't restore
    " original content cleanly after running exec.
    redraw!
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
=====================

vim plugin to reflesh your browser. 
this plugin works only MacOSX.

Required
=====================

osascript(AppleScript command)

Installation
=====================

::

 wget https://github.com/tell-k/vim-browsereload-mac/tarball/master -O browsereload-mac-vim.tar.gz
 tar xvzf browsereload-mac-vim.tar.gz
 mv tell-k-vim-browsereload-mac-* browsereload-mac-vim
 cp -pr ./browsereload-mac-vim/plugin/browsereload-mac.vim ~/.vim/plugin/ 

see also install.sh

Note
=====================

if you want to reload Firefox. Please change your System Preferences on MacOSX as below.

check "Enable access for assistive devices"::

 System Preferences > Universal Access > "Enable access for assistive devices"


Usage
=====================

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
=====================

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
 let g:returnAppFlag = 1

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

You can define "reloadPreHook" and "reploadPostHook" commands.

::

 " default is not setting.  
 " 1. execute "reloadPreHook" command. -> 2. refresh browser.
 let g:reloadPreHook = "sh bulid_assets.sh"

 " 1. refresh browser. ->  2. execute "reloadPostHook" command.
 let g:reloadPostHook = "sh bulid_assets.sh"

I recommend that you use along with the `vimproc.vim <https://github.com/Shougo/vimproc.vim>`_.  
Because hook commands to be performed asynchronously.

