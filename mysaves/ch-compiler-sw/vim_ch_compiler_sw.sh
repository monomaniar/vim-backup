mkdir -p ~/.vimtags_filetypes
touch ~/.vimtags_filetypes/cpp
mkdir -p ~/.vim/mysaves/ch-compiler-sw/
touch ~/.vim/mysaves/ch-compiler-sw/viminfo
touch ~/.vim/mysaves/ch-compiler-sw/session
cd /home/wuranbo/CH-svn/car-navi-compiler-sw_1-0-0-0_PD_BL
./ctags.sh
vim -c "nnoremap <silent> <Leader>ff  :Unite -input=/home/wuranbo/CH-svn/car-navi-compiler-sw_1-0-0-0_PD_BL/ -buffer-name=buffer file_mru bookmark file<CR>" -c "set tags=~/CH-svn/car-navi-compiler-sw_1-0-0-0_PD_BL/tags,~/.vimtags_filetypes/cpp" -c "set path+=/home/wuranbo/CH-svn/car-navi-compiler-sw_1-0-0-0_PD_BL/" -c "autocmd VimLeavePre * :mksession! ~/.vim/mysaves/ch-compiler-sw/session" -c "autocmd VimLeavePre * :wviminfo ~/.vim/mysaves/ch-compiler-sw/viminfo" -c "autocmd VimEnter * :rviminfo ~/.vim/mysaves/ch-compiler-sw/viminfo" -S "~/.vim/mysaves/ch-compiler-sw/session"
