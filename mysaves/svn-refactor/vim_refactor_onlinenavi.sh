rm ~/.vimtags_filetypes/cpp
touch ~/.vimtags_filetypes/cpp
cd ~/svn-refactor/onlinenavi/
./ctags.sh
vim -c "nnoremap <silent> <Leader>ff  :Unite -input=/home/wuranbo/svn-refactor/onlinenavi/ -buffer-name=buffer file_mru bookmark file<CR>" -c "set tags=~/svn-refactor/onlinenavi/tags,~/.vimtags_filetypes/cpp"  -c "set path+=/usr/include/c++/4.4.6" -c "set path+=/home/wuranbo/svn-refactor/onlinenavi/" -c "autocmd VimLeavePre * :mksession! ~/.vim/mysaves/svn-refactor/session" -c "autocmd VimLeavePre * :wviminfo ~/.vim/mysaves/svn-refactor/viminfo" -c "autocmd VimEnter * :rviminfo ~/.vim/mysaves/svn-refactor/viminfo" -S "~/.vim/mysaves/svn-refactor/session"
