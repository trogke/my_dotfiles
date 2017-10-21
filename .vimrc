" My vim configuration file
" This file is provided under the terms and conditions
" of the DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
"
""         DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
"                    Version 2, December 2004 
"
" Copyright (C) 2004 Sam Hocevar <sam@hocevar.net> 
"
" Everyone is permitted to copy and distribute verbatim or modified 
" copies of this license document, and changing it is allowed as long 
" as the name is changed. 
"
"            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
"   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION 
"
"  0. You just DO WHAT THE FUCK YOU WANT TO.
"  
" Last changed: 19-10-2017 (DD-MM-YYYY)
" Kevin Trogant

" Be awesome. Strictly speaking, this is unnecessary in most situations
" but better save then sorry.
set nocompatible
set backspace=indent,eol,start
" I use pathogen for things that can not be installed via vim-plug
execute pathogen#infect()

" Enable syntax highlighting and auto-indent.
" Theme settings go here as well
syntax on
filetype plugin indent on
set background=dark
if !has('gui_running')
	let g:solarized_termcolors=256
endif
colorscheme solarized

" Install plugins in ./vim/plugged
" We specify all plugins here
" This depends on vim-plug
call plug#begin('~/.vim/plugged')

" Vim plugin for fzf
" A fuzzy finder that enables us to search buffers, files, etc.
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'

" Plugin for using ack/ag for searching inside the current project
Plug 'mileszs/ack.vim'

" vim-unimpaired gives us easy to use shortcuts for :cnext, :cprev etc.
Plug 'tpope/vim-unimpaired'

" goyo gives us distraction-free writing in vim
Plug 'junegunn/goyo.vim'

" lightline is a leightweight status line
Plug 'itchyny/lightline.vim'

" ALE is an asynchronous linting engine
Plug 'w0rp/ale'

" Show markers for changes, when using git
Plug 'airblade/vim-gitgutter'

" Git integration with git-fugitive. Enough said.
Plug 'tpope/vim-fugitive'

" Use gc in visual mode to comment out lines
Plug 'tpope/vim-commentary'

call plug#end()

" make ack.vim use ag
if executable('ag')
	let g:ackprg = 'ag --vimgrep'
endif

" ProseMode
" (From: https://statico.github.io/vim3.html)
" I like the idea and since i get easily distracted while writing,
" i thought i would give it a shot
function! ProseMode()
  call goyo#execute(0, [])
  set spell noci nosi noai nolist noshowmode noshowcmd
  set spelllang=de_DE
  set complete+=s
  set bg=light
  if !has('gui_running')
    let g:solarized_termcolors=256
  endif
  colors solarized
endfunction
command! ProseMode call ProseMode()

" Lightline
set laststatus=2
let g:lightline = {
			\ 'colorscheme': 'solarized',
			\}

" ALE
" Since i often run on battery, i want ALE to not run that often
" 400ms delay after typing before the linter runs
let g:ale_lint_delay = 400

" Keyboard shortcuts
" Configure leader to be ,
let mapleader = ","

" Configure fzf
" We set ; to :Buffers  ,t to :Files and ,r to :Tags
nmap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>

" Trigger Prose mode with ,p
nmap <Leader>p :ProseMode<CR>

" Remap [ to < and ] to >, because i have a german keyboard
" This is usefull for :Ack and makes :cnext and :cprev easily
" accessible.
nmap < [
nmap > ]
omap < [
omap > ]
xmap < [
xmap > ]


" Generate help tags
silent! helptags ALL
