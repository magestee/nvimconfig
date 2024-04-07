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
    " insert 4 spaces for tab
    set tabstop=2 softtabstop=2
    " the number of spaces inserted for each indentation
    set shiftwidth=2
    " convert tabs to spaces
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

    set fileencoding =utf-8 



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

" resize windows with arrow keys:
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" nwdrd on the side 
nnoremap <leader>e :Lex 25<cr>


" next greatest remap ever : asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nmap <leader>Y "+Y

nnoremap <leader>d "_d
vnoremap <leader>d "_d


" indenting like a boss
vnoremap <  <gv
vnoremap >  >gv

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" greatest remap ever doesnt replace the the registe
xnoremap <leader>p "_dP

" Copy the current line to the clipboard
nnoremap <leader>y "*yy
vnoremap <leader>y "*y

" for closing terminal faster
tnoremap <C-]> <C-\><C-n>
tnoremap <C-\> <C-\><C-n>:q!<CR>

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


:set mouse=v
lua << EOF
function OpenRightTerminal()
    -- Define the width for the terminal to be a third of the current window width
    local terminal_width = math.floor(vim.o.columns / 3)
    -- Open a new vertical split to the right
    vim.cmd("vsplit")
    vim.cmd("vertical resize " .. terminal_width)
    -- Move to the new window to the right
    vim.cmd("wincmd L")
    -- Start the terminal
    vim.cmd("terminal")
end

-- Map this function to a key combination, for example <Leader>vt
vim.api.nvim_set_keymap('n', '<Leader>t', '<cmd>lua OpenRightTerminal()<CR>', { noremap = true, silent = true })

EOF
