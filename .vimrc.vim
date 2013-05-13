"
"=========TODO=========================
"===================================================================================
"===read 'Seven habits of effective text editing' http://www.moolenaar.net/habits.html===
"===make youself simliar the utils of linux===sort,cut, tr, paste, find, grep, gawk, sed
"==!使用的三种方式
"1. r !ls ./  ,  !google-chrome %  ,  !gedit % :作为shell执行,与vim指令配合
"2. '<,'>!sort -n ,%!sort -n  :以当前为输入，以sort的结果作为输出
"3. '<,'>w !sort >1.result, 加w以当前部分作为输入，结果不作为输出
"vimshell vimgbd http://clewn.sourceforge.net/ http://www.wana.at/vimshell/
"===========================ranbo forward================
"runtime! debian.vim
"设置leader
let mapleader=","
"==========================changfei=============================
set nu
"set tags=tags;
set autochdir

if version < 700
    echo "~/.vimrc: Vim 7.0+ is required!, you should upgrade your vim to latest version."
    finish
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" common settings section
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
filetype plugin on
filetype plugin indent on

syntax on
syntax enable

"@note this or below
"set t_Co=16
"set t_Co=256
"colorscheme desert

"@note:solarized see the commit under ranbo about colorscheme and terminal
set t_Co=256
"set t_Co=16
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" backup settings not work good
"set backup
"set backupdir=~/.vimbackup

" input settings
set backspace=2
set tabstop=2
set shiftwidth=2
set smarttab
" set softtabstop=4
set expandtab " expand tab to spaces

" indent settiongs
set autoindent
set smartindent
set cindent
set cinoptions=:0,g0,t0,(0,Ws,m1

" search settings
set hlsearch
set incsearch
set smartcase
set ignorecase " Do case insensitive matching 添加\c可忽略大小写

" quickfix settings
compiler gcc

"let g:NeoComplCache_EnableAtStartup = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Display settings section
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ruler
set showmatch
set showmode
set wildmenu
set wildmode=longest:full,full

" status line
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
"set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P


if has("mswin")
    set diffexpr=MyDiff()
    function MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

" auto encoding detecting
set fileencodings=utf-8,cp936,big5,gb18030,ucs,ucs-bom,utf-8-bom
let g:fencview_autodetect = 1

" set term encoding according to system locale
let &termencoding = substitute($LANG, "[a-zA-Z_-]*\.", "", "")

" support gnu syntaxt
let c_gnu = 1

" show error for mixed tab-space
let c_space_errors = 1
"let c_no_tab_space_error = 1

" don't show gcc statement expression ({x, y;}) as error
let c_no_curly_error = 1

" hilight characters over 100 columns
"match DiffAdd '\%>80v.*'
set textwidth=80
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
au BufWinEnter * let w:m2=matchadd('OverLength', '\%>' . &textwidth . 'v.\+', -1)
nnoremap <Leader>hon :highlight OverLength NONE<CR>
nnoremap <Leader>hoo :highlight OverLength ctermbg=red ctermfg=white guibg=#592929<CR>

" hilight extra spaces at end of line
match Error '\s\+$'

let g:load_doxygen_syntax=1

" show tab as --->
" show trailing space  remove trail space because it conflict the abi correct by ranbo
"set listchars=tab:>-,trail:-
"remove show tabl as --> not good to see
"set listchars
"set list

" fix vim quick fix
set errorformat^=%-GIn\ file\ included\ %.%#

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key mappings section
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" F2 to search high lights
"map <F2> :silent! nohlsearch<CR>

" jump to previous building error //do in ranbo
"map <Leader>cp :cp<CR>
" jump to next building error //do in ranbo
"map <Leader>cn :cn<CR>

" run make command
map <F7> :Blade build<CR>

" run make clean command
"map <F6> :Blade clean<CR>

" alt .h .cpp
"map <F7> :A<CR>

"nnoremap <silent> <F8> :TlistToggle<CR>

" QUICKFIX WINDOW
" @see http://c9s.blogspot.com/2007/10/vim-quickfix-windows.html
command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
        cclose
        unlet g:qfix_win
    else
        copen
        let g:qfix_win = bufnr("$")
    endif
endfunction
" toggle quickfix window
"nmap <F10> :QFix<CR>

"map <F10> :NERDTreeToggle<CR>
"imap <F10> <ESC> :NERDTreeToggle<CR>

" F11 toggle paste mode
"set pastetoggle=<F11>
nnoremap <Leader>sp :set paste<CR>
nnoremap <Leader>snp :set nopaste<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" auto commands section
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" remove trailing spaces
function! RemoveTrailingSpace()
    if $VIM_HATE_SPACE_ERRORS != '0'
        normal m`
        silent! :%s/\s\+$//e
        normal ``
    endif
endfunction

" apply gnu indent rule for system headers
function! GnuIndent()
    setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
    setlocal shiftwidth=2
    setlocal tabstop=8
endfunction

" fix inconsist line ending
function! FixInconsistFileFormat()
    if &fileformat == 'unix'
        silent! :%s/\r$//e
    endif
endfunction
autocmd BufWritePre * nested call FixInconsistFileFormat()

" custom indent: no namespace indent, fix template indent errors
function! CppNoNamespaceAndTemplateIndent()
    let l:cline_num = line('.')
    let l:cline = getline(l:cline_num)
    let l:pline_num = prevnonblank(l:cline_num - 1)
    let l:pline = getline(l:pline_num)
    while l:pline =~# '\(^\s*{\s*\|^\s*//\|^\s*/\*\|\*/\s*$\)'
        let l:pline_num = prevnonblank(l:pline_num - 1)
        let l:pline = getline(l:pline_num)
    endwhile
    let l:retv = cindent('.')
    let l:pindent = indent(l:pline_num)
    if l:pline =~# '^\s*template\s*<\s*$'
        let l:retv = l:pindent + &shiftwidth
    elseif l:pline =~# '^\s*template\s*<.*>\s*$'
        let l:retv = l:pindent
    elseif l:pline =~# '\s*typename\s*.*,\s*$'
        let l:retv = l:pindent
    elseif l:pline =~# '\s*typename\s*.*>\s*$'
        let l:retv = l:pindent - &shiftwidth
    elseif l:cline =~# '^\s*>\s*$'
        let l:retv = l:pindent - &shiftwidth
    elseif l:pline =~# '^\s\+: \S.*' " C++ initialize list
        let l:retv = l:pindent + 2
    elseif l:pline =~# '^\s*namespace.*'
        let l:retv = 0
    endif
    return l:retv
endfunction
autocmd FileType cpp nested setlocal indentexpr=CppNoNamespaceAndTemplateIndent()

augroup filetype
    autocmd! BufRead,BufNewFile *.proto set filetype=proto
    autocmd! BufRead,BufNewFile *.thrift set filetype=thrift
    autocmd! BufRead,BufNewFile *.pump set filetype=pump
    autocmd! BufRead,BufNewFile BUILD set filetype=blade
augroup end

" When editing a file, always jump to the last cursor position
autocmd BufReadPost * nested
            \ if line("'\"") > 0 && line ("'\"") <= line("$") |
            \ exe "normal g'\"" |
            \ endif

autocmd BufEnter /usr/include/c++/* nested setfiletype cpp
autocmd BufEnter /usr/include/* nested call GnuIndent()
autocmd BufWritePre * nested call RemoveTrailingSpace()
autocmd FileType make nested colorscheme murphy |

function SetLogHighLight()
    highlight LogFatal ctermbg=red guifg=red
    highlight LogError ctermfg=red guifg=red
    highlight LogWarning ctermfg=yellow guifg=yellow
    highlight LogInfo ctermfg=green guifg=green
    syntax match LogFatal "^F\d\+ .*$"
    syntax match LogError "^E\d\+ .*$"
    syntax match LogWarning "^W\d\+ .*$"
    " syntax match LogInfo "^I\d\+ .*$"
endfunction
autocmd BufEnter *.{log,INFO,WARNING,ERROR,FATAL} nested call SetLogHighLight()

" auto insert gtest header inclusion for test source file
autocmd BufNewFile *_test.{cpp,cxx,cc} nested :normal i#include "thirdparty/gtest/gtest.h"

" locate project dir by BLADE_ROOT file
functio! FindProjectRootDir()
    let rootfile = findfile("BLADE_ROOT", ".;")
    " in project root dir
    if rootfile == "BLADE_ROOT"
        return ""
    endif
    return substitute(rootfile, "/BLADE_ROOT$", "", "")
endfunction

" set path automatically
function! AutoSetPath()
    let project_root = FindProjectRootDir()
    if project_root != ""
        exec "setlocal path+=" . project_root
    endif
endfunction
autocmd FileType {c,cpp} nested call AutoSetPath()

" auto insert gtest header inclusion for test source file
function! s:InsertHeaderGuard()
    let fullname = expand("%:p")
    let rootdir = FindProjectRootDir()
    if rootdir != ""
        let path = substitute(fullname, "^" . rootdir . "/", "", "")
    else
        let path = expand("%")
    endif
    let varname = toupper(substitute(path, "[^a-zA-Z0-9]", "_", "g")) . "_"
    exec 'norm O#ifndef ' . varname
    exec 'norm o#define ' . varname
"   exec 'norm o#pragma once'
    exec '$norm o#endif // ' . varname
endfunction
autocmd BufNewFile *.{h,hh.hxx,hpp} nested call <SID>InsertHeaderGuard()

autocmd QuickFixCmdPost * :QFix

autocmd FileType python syn keyword Function self

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom commands sections
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" integrate blade into vim
function! Blade(...)
    let l:old_makeprg = &makeprg
    setlocal makeprg=blade
    execute "make " . join(a:000)
    let &makeprg=old_makeprg
endfunction
command! -complete=dir -nargs=* Blade call Blade('<args>')

" integrate cpplint into vim
function! CppLint(...)
    let l:args = join(a:000)
    if l:args == ""
        let l:args = expand("%")
        if l:args == ""
            let l:args = '*'
        endif
    endif
    let l:old_makeprg = &makeprg
    setlocal makeprg=cpplint.py
    execute "make " . l:args
    let &makeprg=old_makeprg
endfunction
command! -complete=file -nargs=* CppLint call CppLint('<args>')

"" integrate pychecker into vim
"function! PyCheck(...)
"    let l:old_makeprg = &makeprg
"    setlocal makeprg=pychecker
"    execute "make -q " . join(a:000)
"    let &makeprg=old_makeprg
"endfunction
"command! -complete=file -nargs=* PyCheck call PyCheck('<args>')
"==============================ranbo=config====================================
"colorscheme
"http://ethanschoonover.com/solarized
"terminal color
"https://github.com/sigurdga/gnome-terminal-colors-solarized/tree/gnome-3.8
"======xmllint======
"au FileType xml exe \":silent 1,$!xmllint --format --recover - 2>/dev/null"
"au 导致会删除
function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()
"==json==%!python -m json.tool
"move in the QUICKFIX
"move in the location-list 要用nnoremap
nnoremap <Leader>cn :cn<CR>
nnoremap <Leader>ln :lne<CR>
nnoremap <Leader>cp :cp<CR>
nnoremap <Leader>lp :lp<CR>
"定义快捷键保持当前窗口内容.syntastic插件locationlist和quicklist冲突的bug
nnoremap <Leader>w :w<CR>:w<CR>
"delete mark
nnoremap <Leader>dm :delmarks
"popup setting
set completeopt=menuone,menu,longest,preview
" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd " Show (partial) command in status line.
set autowrite " Automatically save before commands like :next and :make
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
" Use visual bell instead of beeping when doing something wrong
set visualbell
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
" Always display the status line, even if only one window is displayed
set laststatus=2
"命令行高度
set cmdheight=2
" Better command-line completion
set wildmenu
"否则切换buff会提示必须保存
set hidden
"下划线
set cursorline

"定义edit
nnoremap <Leader>e :e
"定义quit
noremap <Leader>q :q<CR><Esc>
" nohl
nnoremap <Leader>nh :nohl<CR><ESC>
"设置快捷键将选中文本块复制至系统剪贴板
vnoremap<Leader>y "+y
vnoremap<Leader>1y "1y
vnoremap<Leader>2y "2y
vnoremap<Leader>3y "3y
vnoremap<Leader>4y "4y
vnoremap<Leader>5y "5y
vnoremap<Leader>6y "6y
vnoremap<Leader>7y "7y
vnoremap<Leader>8y "8y
vnoremap<Leader>9y "9y
"设置快捷键将系统y剪贴板内容粘贴至vim
vnoremap<Leader>p "+p
vnoremap<Leader>1p "1p
vnoremap<Leader>2p "2p
vnoremap<Leader>3p "3p
vnoremap<Leader>4p "4p
vnoremap<Leader>5p "5p
vnoremap<Leader>6p "6p
vnoremap<Leader>7p "7p
vnoremap<Leader>8p "8p
vnoremap<Leader>9p "9p


nmap <Leader>bp :bp<cr>
nmap <Leader>bn :bn<cr>
nmap <Leader>b1 :b1<cr>
nmap <Leader>b2 :b2<cr>
nmap <Leader>b3 :b3<cr>
nmap <Leader>b4 :b4<cr>
nmap <Leader>b5 :b5<cr>
nmap <Leader>b6 :b6<cr>
nmap <Leader>b7 :b7<cr>
nmap <Leader>b8 :b8<cr>
nmap <Leader>b9 :b9<cr>
nmap <Leader>b0 :b0<cr>
" shell script运行
map <silent> <F9> :call CompileRunSH()<CR>:ccl<CR>
func! CompileRunSH()
exec "w"
exec "!chmod a+x %"
exec "!./%"
endfunc
" python运行
map <silent> <F8> :call CompileRunPyhton()<CR>:ccl<CR>
func! CompileRunPyhton()
exec "w"
exec "!chmod a+x %"
exec "!./%"
endfunc
"close the quickfix window
nmap <silent> <Leader>cll :ccl<CR>
" Automatically read a file that has changed on disk
set autoread
" Search the current file for what's currently in the search register and display matches
nmap <silent> <Leader>gs :vimgrep /<C-r>// %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

" Search the current file for the word under the cursor and display matches
nmap <silent> <Leader>gw :vimgrep /<C-r><C-w>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

" Search the current file for the WORD under the cursor and display matches
nmap <silent> <Leader>gW :vimgrep /<C-r><C-a>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>
"menu color
"set completeopt=longest,menu

"cd to the pwd of the curent file
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>
"ctags 跳转
nmap <Leader>ts :tselect
"=========install a.vim=======================================================================
"=========install sudo.vim=======================================================================
"====http://www.vim.org/scripts/script.php?script_id=31===
"=========================neocomplcache===========================================================================
"=====https://github.com/Shougo/neocomplcache=====
"===https://github.com/Shougo/neocomplcache-snippets-complete==更改了部分snipt
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 2
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup(). "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup() . "\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup() . "\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 0
let g:neocomplcache_enable_auto_delimiter=1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"autocmd filetype cpp set omnifunc=omni#cpp#complete#Main
"autocmd FileType cpp setlocal omnifunc=cppcomplete#CompleteTags
"autocmd FileType java setlocal omnifunc=javacomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
let g:neocomplcache_omni_patterns = {}
endif
"let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.javascript = '\h\w*\%(\.\|->\)\h\w*\|\h\w*:'
"=====================unite.vim=========================================================================
"====https://github.com/Shougo/unite.vim==
"====tags plugin unite.vim==https://github.com/tsukkee/unite-tag
"=====mark plugin unite.vim==https://github.com/tacroe/unite-mark
"=====================================================
"Unite.vim The prefix key.
"=====================================================
"nmap    f [unite]
"默认使用当前目录 files会自动扩展文件，试试去掉以验证有循环symbolic
"link时候会卡的问题
nnoremap <silent> <F5>  :UniteWithCurrentDir  -buffer-name= file<CR>
nnoremap <silent> <Leader>ff  :UniteWithCurrentDir  -buffer-name= buffer file_mru bookmark file<CR>
"不同的工程用不同的目录

"buff reg
nnoremap <silent> <Leader>fm  :Unite mark<CR>
nnoremap <silent> <F4>  :Unite tag<CR>
nnoremap <silent> <Leader>ft  :Unite tag<CR>
nnoremap <silent> <Leader>fb  :Unite -buffer-name= buffer file_mru bookmark file<CR>
nnoremap <silent> <Leader>fr  :Unite -buffer-name= register register<CR>
nnoremap <silent> <Leader>fo  :Unite outline<CR>
"nnoremap  <Leader>[unite]s  :Unite source<CR>

" Start insert.
"let g:unite_enable_start_insert = 1

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  " Overwrite settings.

  nmap <buffer> <ESC>      <Plug>(unite_exit)
  imap <buffer> jj      <Plug>(unite_insert_leave)
  "imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

  " <C-l>: manual neocomplcache completion.
  inoremap <buffer> <C-l>  <C-x><C-u><C-p><Down>
endfunction"}}}

let g:unite_source_file_mru_limit = 200
"let g:unite_cursor_line_highlight = 'TabLineSel'
"let g:unite_abbr_highlight = 'TabLine'

" For optimize.
let g:unite_source_file_mru_filename_format = ''
"===============================grep.vim============================
"F3使用grep
nnoremap <silent> <F3>  :Rgrep<CR>
"skipfile
let Grep_Skip_Files='*.bak *~ *.mk .*.swp *.o tags'
"skipdir
let Grep_Skip_Dirs='.svn RCS CVS SCCS .git'
"default files
let Grep_Default_Filelist='*.cpp *.cc *.c *.proto *.h *.py *.html *.js *.java *.sh *.asm'
"=========================pyflakes-vim================
"Make sure your .vimrc has:
"
filetype on            " enables filetype detection
filetype plugin on     " enables filetype specific plugins
"Set this option in your vimrc file to disable quickfix support:

let g:pyflakes_use_quickfix = 1
"=================================for easytags====================================================
"====http://www.vim.org/scripts/script.php?script_id=3114
"=====非常慢，需要提速==
let g:easytags_on_cursorhold = 1
"9 second is 9000
let g:easytags_updatetime_min = 15000
let g:easytags_always_enabled = 0
let g:easytags_auto_update = 1
let g:easytags_auto_highlight = 1

let g:easytags_resolve_links = 1
let g:easytags_by_filetype="~/.vimtags_filetypes/"
let g:easytags_cmd="/usr/bin/ctags"
"include members need ctags.sh --extra=+q, easy to become tagsfile too big
let g:easytags_include_members = 1
"
"./tags also used
let g:easytags_dynamic_files = 1
let g:easytags_python_enabled = 1
let g:easytags_python_script = 1
"===========================================syntastic==========================
"for syntastic
"let g:syntastic_cpp_include_dirs = [ '../','../../','../../../', 'includes' ]
"let g:syntastic_cpp_include_dirs = [ 'includes', '../../','../','../../../' ]
"let b:syntastic_cpp_cflags =  '-I/home/wrb/common_library/trunk -I/home/wrb/XLong4.6/include/ -I/home/wrb/XLong4.6/include/mtl/'
"let b:syntastic_cpp_cflags =  ' -I/home/wrb/XLong4.6/include/ -I/home/wrb/XLong4.6/include/mtl/'
"let b:syntastic_c_cflags = ' -I/home/wuranbo/common_library/trunk'
let g:syntastic_cpp_no_include_search = 1
let g:syntastic_c_no_include_search = 1
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_c_remove_include_errors = 1
"-pedantic 学究
"let g:syntastic_cpp_compiler_options='-std=c++0x -O2 -Wall -pipe -Wextra -Wendif-labels -Wfloat-equal -Wformat=2 -Wframe-larger-than=65536 -Wmissing-include-dirs -Wpointer-arith -Wwrite-string -Wno-invalid-offsetof -Wvla -Wabi -Wconversion-null -Wctor-dtor-privacy -Wdelete-non-virtual-dtor -Wnarrowing -Wnoexcept -Wnon-virtual-dtor -Wreorder -Weffc++ -Wstrict-null-sentinel -Wno-non-template-friend -Wold-style-cast -Woverloaded-virtual -Wno-pmf-conversions -Wsign-promo -Wdouble-promotion -Wformat-y2k -Wformat-nonliteral -Wformat-security -Wformat=2 -Winit-self -Wswitch-default -Wswitch-enum -Wsync-nand -Wunused-local-typedefs -Wunused-parameter --Wunused -Wmaybe-uninitialized -Wuninitialized --Wstrict-overflow=5 -Wstrict-aliasing=3 -Wtrampolines -Wshadow -Wstack-usage=10000000 -Wframe-larger-than=8000000 -Wunsafe-loop-optimizations -Wpointer-arith -Wbad-function-cast -Wc++-compat -Wcast-qual -Wconversion -Wjump-misses-init -Waggregate-return -Wmissing-prototypes -Winline -Wdisabled-optimization'

"let g:syntastic_cpp_compiler_options='-std=c++0x -g -ggdb -Wall -pipe -Wextra -Wendif-labels -Wfloat-equal -Wformat=2 -Wframe-larger-than=65536 -Wmissing-include-dirs -Wpointer-arith -Wwrite-string -Wno-invalid-offsetof -Wvla -Wabi -Wconversion-null -Wctor-dtor-privacy -Wdelete-non-virtual-dtor -Wnarrowing -Wnoexcept -Wnon-virtual-dtor -Wreorder -Weffc++ -Wstrict-null-sentinel -Wno-non-template-friend -Wold-style-cast -Woverloaded-virtual -Wno-pmf-conversions -Wsign-promo -Wdouble-promotion -Wformat-y2k -Wformat-nonliteral -Wformat-security -Wformat=2 -Winit-self -Wswitch-default -Wswitch-enum -Wsync-nand -Wunused-local-typedefs -Wunused-parameter --Wunused -Wmaybe-uninitialized -Wuninitialized --Wstrict-overflow=5 -Wstrict-aliasing=3 -Wtrampolines -Wshadow -Wstack-usage=10000000 -Wframe-larger-than=8000000 -Wunsafe-loop-optimizations -Wpointer-arith -Wbad-function-cast -Wc++-compat -Wcast-qual -Wconversion -Wjump-misses-init -Waggregate-return -Wmissing-prototypes -Winline -Wdisabled-optimization'
let g:syntastic_c_compiler_options='-std=c++0x -Wall -Wextra -Wno-unused-parameter -Wno-missing-field-initializers -Wendif-labels -Wfloat-equal -Wformat=2 -Wmissing-include-dirs -Wpointer-arith -Wwrite-strings -Winline'
let g:syntastic_c_compiler_options=' -Wall -pipe '
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
"status line 有bug
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntax_on=1 "语法
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let syntastic_check_on_open = 0 "打开文件时候是否检测
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:syntastic_enable_highlighting=1
let g:syntastic_enable_signs=1
let g:syntastic_auto_jump=1
let g:syntastic_enable_balloons=1
let g:syntastic_auto_loc_list=1
"let g:syntastic_quiet_warnings=0
"syntastic for c
let g:syntastic_c_check_header = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_c_no_include_search = 1
let g:syntastic_cpp_no_include_search = 1
"==========================================================buf===NERDTREE=========================
"使用minibufexpl.vim插件管理buffer，设置允许光标在任意位置时，通过CTRL-TAB遍历buffer
"let g:miniBufExplMapCTabSwitchBufs=1
"使用NERDTree插件查看工程文件。设置快捷键，速记法：filelist
nmap <Leader>fl :NERDTreeToggle<CR><C-w>h
""设置NERDTree子窗口宽度
let NERDTreeWinSize=23
"设置NERDTree子窗口位置
let NERDTreeWinPos="left"
"===============install======nerdcomment===========================================================
"更改python和cpp的left comment==
"====================================doxygentoolkit=====================
" 	 - Insert position is correct when
let g:doxygen_enhanced_color=1
"压缩无空行
let g:DoxygenToolkit_compactOneLineDoc = "yes"
let g:DoxygenToolkit_compactDoc = "yes"
" 	   and let use C++ type make the syntax highlight not work

let g:DoxygenToolkit_commentType = "C" "手动变C++
    let g:DoxygenToolkit_startCommentTag = "/// "
    let g:DoxygenToolkit_interCommentTag = "/// "
    let g:DoxygenToolkit_endCommentTag = ""
    let g:DoxygenToolkit_startCommentBlock = "// "
    let g:DoxygenToolkit_interCommentBlock = "// "
    let g:DoxygenToolkit_endCommentBlock = ""

" 	 - When you define:
"let g:DoxygenToolkit_briefTag_funcName = "yes"
"
""change the default tag name also make the highlight synstax not work
""so do not change
let g:DoxygenToolkit_briefTag_pre="@brief "
let g:DoxygenToolkit_paramTag_pre="@param "
let g:DoxygenToolkit_returnTag="@returns "
"
let g:DoxygenToolkit_blockHeader=""
let g:DoxygenToolkit_blockFooter=""
let g:DoxygenToolkit_authorName="ranbo.wu@autonavi.com CopyRight(c) AutoNavi Inc."
let g:DoxygenToolkit_licenseTag="CopyRight(c) AutoNavi Inc. ranbo.wu@autonavi.com"
"==============taglist===============================================
"move to taglist.vim
"function! TlistToggleRight()
  "let Tlist_Use_Right_Window=1
  "call s:TList_Window_Toggle()
  "let Tlist_Use_Right_Window=0
"endfunction
"command! TlistToggleRight call TlistToggleRight()

nmap <silent> <Leader>tl :TlistToggle<CR>
nmap <silent> <leader>tr :TlistToggleRight<CR>
let Tlist_Exit_OnlyWindow=1
"let Tlist_Auto_Update=1
"let Tlist_File_Fold_Auto_Close=1
let Tlist_WinWidth=43
let Tlist_Display_Prototype=0
let Tlist_Show_One_File=1
"===============install autotag.vim===================autoupdate tagfiles======
"http://www.vim.org/scripts/script.php?script_id=1343
"=========使用shift+K可以直接看光标下的词的manual==
"====source  man.vim=================
source $VIMRUNTIME/ftplugin/man.vim
nnoremap K :Man <C-R><C-W><CR>
"=========json.vim=====json highlight==========
"===http://www.vim.org/scripts/script.php?script_id=1945
au! BufRead,BufNewFile *.json set filetype=json
augroup json_autocmd
  autocmd!
  autocmd FileType json set autoindent
  autocmd FileType json set formatoptions=tcq2l
  autocmd FileType json set textwidth=78 shiftwidth=2
  autocmd FileType json set softtabstop=2 tabstop=8
  autocmd FileType json set expandtab
  autocmd FileType json set foldmethod=syntax
augroup END
"======add to the head of indent/python.vim with what the google-python-style-guide gives===================
"ranbo add for python
autocmd FileType python setlocal et sta sw=4 sts=4
autocmd FileType javascript setlocal et sta sw=4 sts=4
autocmd FileType html setlocal et sta sw=4 sts=4
"==============DirDiff==========
"http://www.vim.org/scripts/script.php?script_id=102
let g:DirDiffWindowSize = 10
let g:DirDiffIgnore = "Id:,Revision:,Date:"
let g:DirDiffExcludes = "CVS,*.class,*.exe,.*.swp,*.bak,*.gch,*.gdb,core.*"


"=====c++ syntax=======google.vim===================
"http://www.vim.org/scripts/script.php?script_id=2636
"
"=======google's js style======
"http://google-styleguide.googlecode.com/svn/trunk/javascriptguide.xml=
"==http://www.whatwg.org/   http://www.w3.org/===================
"
"===javascript.vim javascript syntax=====================
"======http://www.vim.org/scripts/script.php?script_id=1491==
"===html5-syntax===========
"==http://www.vim.org/scripts/script.php?script_id=3232
"====html5.vim======
"==https://github.com/othree/html5.vim
"===proto.vim====
"==in the protobuf google's svn, path:/editors/proto.vim' cp to synstax
"==color vim====
"==http://www.vim.org/scripts/script.php?script_id=3567
"when need use, can use setf to change the file syntax file in /vim73/syntax/
"This plugin defines three commands:
"
"ColorHighlight - start/update highlighting
"ColorClear      - clear all highlights
"ColorToggle     - toggle highlights
"
"By default, <leader>tc is mapped to ColorToggle. If you want to use another
"key map, do like this:
"nmap ,tc <Plug>Colorizer
"
"If you want completely not to map it, set the following in your vimrc:
"      let g:colorizer_nomap = 1
"
"      To use solid color highlight, set this in your vimrc (later change won't
"      probably take effect unless you use ':ColorHighlight!' to force update):
"            let g:colorizer_fgcontrast = -1
"            set it to 0 or 1 to use a softened foregroud color.
"
"            Note: if you modify a color string in normal mode, if the cursor is
"            still on
"            that line, it'll take 'updatetime' seconds to update. You can use
"            :ColorHighlight (or your key mapping) again to force update.
"
"            Performace Notice: In terminal, it may take several seconds to
"            highlight 240
"            different colors. GUI version is much quicker.

"======================================not install plugins=============
"======JavaScript lint docs runtime======
"====json format %!python -m json.tool
"====notice not install http://www.vim.org/scripts/script.php?script_id=4079=
"===http://www.vim.org/scripts/script.php?script_id=4050
"=====notice flake8 pep8 they are something about python style===conflict wiht howu  google===not install==

"==================================================================================
" Fix constant spelling mistakes
"-----------------------------------------------------------------------------
iab howu       home
iab wiht       with
iab algroithm  algorithm
iab homw       home
iab Acheive    Achieve
iab acheive    achieve
iab Alos       Also
iab alos       also
iab Aslo       Also
iab aslo       also
iab Becuase    Because
iab becuase    because
iab Bianries   Binaries
iab bianries   binaries
iab Bianry     Binary
iab bianry     binary
iab Charcter   Character
iab charcter   character
iab Charcters  Characters
iab charcters  characters
iab Exmaple    Example
iab exmaple    example
iab Exmaples   Examples
iab exmaples   examples
iab Fone       Phone
iab fone       phone
iab Lifecycle  Life-cycle
iab lifecycle  life-cycle
iab Lifecycles Life-cycles
iab lifecycles life-cycles
iab Seperate   Separate
iab seperate   separate
iab Seureth    Suereth
iab seureth    suereth
iab Shoudl     Should
iab shoudl     should
iab Taht       That
iab taht       that
iab Teh        The
iab teh        the
iab verctor    vector
iab lenght     length
iab gerp       grep
iab fnid       find
iab valude     value
iab paln       plan
iab tset       test
iab szie       size
iab XLOngLib  XLongLib
iab XLongLIb  XLongLib
iab XLOngLIb  XLongLib
