set nocompatible
source $VIMRUNTIME/vimrc_example.vim
" source $VIMRUNTIME/mswin.vim

filetype plugin indent on
"颜色
set t_Co=256 "颜色深度,让色彩更丰富
colors molokai "我最喜欢的配色方案

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T " hide Toolbar
    set guioptions-=m " hide menu
    set guioptions-=L " hide Left scrollbar
    set guioptions-=r " hide right scrollbar
    if has('win32')
        set guifont=Courier_New:h14:cANSI
    endif
endif

"文件
set fileencodings=ucs-bom,utf-8,gbk,big5,latin1
set autoread "文件更新后自动读取
set noswapfile "禁用swap文件
set nobackup "no file with ~
set autochdir "自动切换当前目录
set wildignore=*.o,*~,*.pyc " Ignore compiled files

"Tab
set expandtab
set smarttab
set tabstop=4

"缩进
set shiftwidth=4
set smartindent

set whichwrap+=<,>,h,l

"代码
set nowrap
set number
set incsearch
set cursorline " cursorcolumn
set list
set listchars=tab:>-,trail:- " show tabs and trailing spaces
let g:loaded_matchparen=1 " turn off parenthese match

" No annoying sound on errors
set noerrorbells
set novisualbell
set tm=500

" map ; to :, make cmd easy
nnoremap ; :
map <F5> :!python %<cr>

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
nmap <leader>w :w!<cr> " Fast saving
nmap <leader>x :x<cr>  " Fast exit
nmap <leader>q :q!<cr>  " Fast exit
nmap <leader>e :e!<cr>  " Fast reload
nmap <leader>h :noh<cr>  " Fast rm highlight

" tab navigation
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tn :tabnew<CR>
nnoremap tc :tabclose<CR>
nnoremap tm :tabmove<CR>
nnoremap to :tabonly<CR> " close other tabs

" window nav
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <C-down> mz:m+<cr>`z
nmap <C-up> mz:m-2<cr>`z
vmap <C-down> :m'>+<cr>`<my`>mzgv`yo`z
vmap <C-up> :m'<-2<cr>`>my`<mzgv`yo`z

call pathogen#infect()

nnoremap tt :NERDTreeToggle<CR>
let g:pydiction_location = '~/.vim/ftplugin/pydiction/complete-dict'

" Delete trailing white space on save
autocmd BufWritePre * :%s/\s\+$//ge

" auto load vimrc if change
autocmd! bufwritepost _vimrc source %

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.*<left><left><left><left><left><left><left><left>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
