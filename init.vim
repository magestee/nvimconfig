"** THE USER INTERFACE **
    set signcolumn=yes
    set nowrap
" Thick ass curser is all I want
    set guicursor=
" relative number from where I'm at
    set relativenumber
" Give more space for displaying messages.
    set cmdheight=1
" I want a column in 80 spaces away so I know how forward I am.
    set colorcolumn=80

" ** THE BAHAIVIOR **
" spacing and indent settings
    set tabstop=4 softtabstop=4
    set shiftwidth=4
    set expandtab
    set smartindent
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
    set updatetime=50
" search settings
" I don't want highlighting to stay on after search
    set nohlsearch
    set incsearch
" Don't pass messages to |ins-completion-menu|.
    set shortmess+=c
" Scrolling
    set scrolloff=8


" Things that I haven't researched yet (I just copied and pasted):
" set ls=0
set hidden
set noerrorbells
set nu
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set termguicolors
set noshowmode
set isfname+=@-@


" KEYMAPS:
let mapleader = " "

" greatest remap ever
xnoremap <leader>p "_dP

" next greatest remap ever : asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nmap <leader>Y "+Y

nnoremap <leader>d "_d
vnoremap <leader>d "_d

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" for when I used parenthesis matcher. no longer needed.
"inoremap <C-]> <esc><S-a>
"inoremap <C-\> <C-o><leader>

"Imports
runtime ./plug.vim
if has("unix")
  let s:uname = system("uname -s")
  " Do Mac stuff
  if s:uname == "Darwin\n"
    runtime ./macos.vim
  endif
endif
if has('win32')
  runtime ./windows.vim
endif

runtime ./maps.vim
