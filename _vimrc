set nocompatible
source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim

"===============================
"plugins
filetype plugin indent on
call pathogen#infect()

let g:PythonAutoAddImports = 1 "python imports

nnoremap tt :NERDTreeToggle<CR>

nnoremap TT :TlistToggle<CR>
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Use_Right_Window=1
let Tlist_Show_One_File=1

let g:rainbow_active=1
let g:rainbow_operators=1

"yankring settings: press f3 to show clipboard list
nnoremap <silent> <F3> :YRShow<cr>
inoremap <silent> <F3> <ESC>:YRShow<cr>

"appearence

"GUI
if has("gui_running")
    set guioptions-=T " hide Toolbar
    set guioptions-=m " hide menu
    set guioptions-=L " hide Left scrollbar
    set guioptions-=r " hide right scrollbar
    if has('win32')
        set guifont=Courier_New:h14:cANSI
    endif
endif

set t_Co=256
colors molokai

set nowrap
"if set, cusor will move to next line while hit first or last char
"set whichwrap+=<,>,h,l,[,]

set number
"set relativenumber

set textwidth=100
set colorcolumn=100

set cursorline
"set cursorcolumn

set list
set listchars=tab:>-,trail:- " show tabs and trailing spaces

let g:loaded_matchparen=1 " turn off parenthese match

"file
set fileencodings=ucs-bom,utf-8,gbk,big5,latin1
set autoread "文件更新后自动读取
set noswapfile "禁用swap文件
set nobackup "no file with ~
set autochdir "自动切换当前目录
set wildignore=*.o,*~,*.pyc " Ignore compiled files
" Remember info about open buffers on close
set viminfo^=%

"indent
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4
set smartindent

"search
set gdefault
set ignorecase
set smartcase
set incsearch
set hlsearch

"key mapping
"===============================
"map leader
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

nmap <leader>w :w!<cr>
nmap <leader>x :x<cr>
nmap <leader>q :q!<cr>
nmap <leader>e :e!<cr>
nmap <leader>h :noh<cr>

"map ; to :, make cmd easy
nnoremap ; :
inoremap jj <ESC>

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

map <F5> :!python %<cr>

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

" Delete trailing white space on save
autocmd BufWritePre * :%s/\s\+$//ge

" auto load vimrc if change
autocmd! bufwritepost _vimrc source %

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

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
" map <leader>cc :botright cope<cr>
" map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
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
