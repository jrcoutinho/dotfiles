" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" ================ Basic Configurations ================
set number

" mappings
let mapleader = ","
inoremap hj <esc>
inoremap <c-u> <esc>vbUea
nnoremap <c-u> vbUe
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" ================ Set Backup Directory =============================
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set backupdir=~/.vim/tmp,.
  set directory==~/.vim/tmp,.
