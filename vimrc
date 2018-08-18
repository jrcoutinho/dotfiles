" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" ================ Basic Configurations ================
set number

" ================ Set Backup Directory =============================
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set backupdir=~/.vim/tmp,.
  set directory==~/.vim/tmp,.
