" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" ================ Vundle Setup ================
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'nvie/vim-flake8'
let g:flake8_show_in_gutter=1	

call vundle#end()
filetype plugin on

" ================ Basic Configurations ================
syntax enable

set number
source $VIMRUNTIME/defaults.vim

" general mappings
let mapleader = ","
inoremap hj <esc>
inoremap <c-u> <esc>vbUea
nnoremap <c-u> vbUe
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" auto-close parenthesis, brackets and braces
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>

" ================ File finder =======================
set path+=**
set wildmenu "diplays all matching files when tab-completing

" ================ Set Backup Directory =============================
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set backupdir=~/.vim/tmp,.
  set directory==~/.vim/tmp,.
endif
