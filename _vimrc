set nocompatible "禁用对vi的兼容,否则vim的高级功能很多不能用

"颜色
syntax on "开启语法高亮,否则代码关键字没有颜色
set t_Co=256 "颜色深度,让色彩更丰富
colors molokai "我最喜欢的配色方案

"文件
set encoding=utf8 "默认编码,可能不需要?
set autoread "文件更新后自动读取
set noswapfile "禁用swap文件

"Tab
set expandtab
set smarttab
set tabstop=4

"缩进
set shiftwidth=4
set autoindent
set smartindent

"代码
set nowrap "不自动换行
"set wrap
set ruler
set number

"快捷键映射
let mapleader = "," "触发各种命令映射的快捷键

" map ; to :, make cmd easy
nnoremap ; :

" tab navigation
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tn :tabnew<CR>
nnoremap tc :tabclose<CR>

" window nav
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" plugs
nnoremap tt :NERDTreeToggle<CR>
