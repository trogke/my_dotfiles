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
set mouse=a

" I use pathogen for things that can not be installed via vim-plug
execute pathogen#infect()
" Installed via pathogen are:
" * nerdtree
" * the solarized colorscheme


" include language specific configuration
for rcfile in split(globpath("~/.vim/vim_languages", "*.vim"), '\n') 
    execute('source '.rcfile)
endfor"

" Install plugins in ./vim/plugged
" We specify all plugins here
" This depends on vim-plug
call plug#begin('~/.vim/plugged')

" Vim plugin for fzf
" A fuzzy finder that enables us to search buffers, files, etc.
Plug '~/.fzf' | Plug 'junegunn/fzf.vim'

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

" Us vim-autocomplete to auto-close braces etc.
"Plug 'Townk/vim-autoclose'

" vim-tmux-navigator for seamless navigation between vim splits and tmux panes
Plug 'christoomey/vim-tmux-navigator'

" vimux to send commands to other tmux panes from vim
Plug 'benmills/vimux'

" winresizer to resize windows
Plug 'simeji/winresizer'

" tagbar to get an overview over file content
Plug 'majutsushi/tagbar'

" youcompleteme
"Plug 'Valloric/YouCompleteMe'

" the nord theme
Plug 'arcticicestudio/nord-vim'

" Gutentags
Plug 'ludovicchabant/vim-gutentags'

" Vim-Completes-Me
Plug 'ajh17/VimCompletesMe'

call plug#end()

" make ack.vim use ag
if executable('ag')
	let g:ackprg = 'ag --vimgrep'
endif

" Enable syntax highlighting and auto-indent.
" Theme settings go here as well
syntax on
filetype plugin indent on

function! SetupColorscheme()
    " Solarized config
    if 0
        " Lightline
        set laststatus=2
        let g:lightline = {
                    \ 'colorscheme': 'solarized',
                    \}
        colorscheme solarized
        set background=dark
        if !has('gui_running')
            let g:solarized_termcolors=256
        endif
    else
        " Lightline
        set laststatus=2
        let g:lightline = {
                    \ 'colorscheme': 'nord',
                    \}
        " Nord config
        let g:nord_underline = 1
        let g:nord_italic = 1
        let g:nord_italic_comments = 1
        let g:nord_uniform_status_lines = 1
        colorscheme nord
    endif
endfunction
call SetupColorscheme()

" Open NERDTree automatically when vim starts up
" and no files where specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Open NERDTree automatically when vim starts up
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree
" Switch to other window
autocmd VimEnter * wincmd p
" Automatically remove a buffer, if a file is renamed or deleted via nerdtree
let NERDTreeAutoDeleteBuffer=1

" ProseMode
" (From: https://statico.github.io/vim3.html)
" I like the idea and since i get easily distracted while writing,
" i thought i would give it a shot
let g:prose_mode_running=0
function! ProseMode()
  if g:prose_mode_running == 0
      call goyo#execute(0, [])
      set spell noci nosi noai nolist noshowmode noshowcmd
      set spelllang=de_de
      set complete+=s
      set bg=light
      if !has('gui_running')
          let g:solarized_termcolors=256
      endif
      colors solarized
      let g:prose_mode_running=1
  else
      call goyo#execute(0, [])
      set nospell ci si ai nolist showmode showcmd
      call SetupColorscheme()
  endif
endfunction
command! ProseMode call ProseMode()


" Configure tabs
set tabstop=4 softtabstop=0 shiftwidth=4 smarttab expandtab

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

" Generate Tags with c
nmap <LEADER>c :!ctags-proj.sh<CR>

" Remap [ to < and ] to >, because i have a german keyboard
" This is usefull for :Ack and makes :cnext and :cprev easily
" accessible.
nmap < [
nmap > ]
omap < [
omap > ]
xmap < [
xmap > ]

" Vertical split with vv
nnoremap <silent> vv <C-w>v

" Run command with vimux using ,vp
map <Leader>vp :VimuxPromptCommand<CR>
" Run last command again with ,vr
map <Leader>vr :VimuxRunLastCommand<CR>

" Trigger Prose mode with F6
nmap <F6> :ProseMode<CR>

" Open NERDTree with <F7>
nmap <F7> :NERDTree<CR>

" Toggle tagbar with F8
map <F8> :TagbarToggle<CR>

" "Training Mode"
" Disable Arrow Keys in normal and insert mode
" noremap  <up> ""
" noremap! <up> <esc>
" noremap  <down> ""
" noremap! <down> <esc>
" noremap  <left> ""
" noremap! <left> <esc>
" noremap  <right> ""
" noremap! <right> <esc>

 nnoremap <up>    <nop>
 nnoremap <down>  <nop>
 nnoremap <left>  <nop>
 nnoremap <right> <nop>
 inoremap <up>    <nop>
 inoremap <down>  <nop>
 inoremap <left>  <nop>
 inoremap <right> <nop>

" Generate help tags
silent! helptags ALL

