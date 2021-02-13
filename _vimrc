" =============================================================================
"        << 判断操作系统是 Windows 还是 Linux 和判断是终端还是 Gvim >>
" =============================================================================
" -----------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
" -----------------------------------------------------------------------------
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

" -----------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif



" =============================================================================
"                          << 以下为软件默认配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < Windows Gvim 默认配置> 做了一点修改
" -----------------------------------------------------------------------------
if (g:iswindows && g:isGUI)
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
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
            " if &sh =~ '\<cmd'
                " let cmd = '""' . $VIMRUNTIME . '\diff"'
                " let eq = '"'
            if &sh =~ '\<cmd'
                let cmd = '"' . $VIMRUNTIME . '\diff"'
                let eq = '""'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif


" =============================================================================
"                          << 以下为用户自定义配置 >>
" =============================================================================

let mapleader = ","                                   "设置leader键为英文逗号
set nocompatible                                      "禁用 Vi 兼容模式
set fillchars=vert:\ ,stl:\ ,stlnc:\ |                " 修改分屏竖线样式为空格

" -----------------------------------------------------------------------------
"  < 新建文件自动插入文件头 >
" -----------------------------------------------------------------------------
augroup AutoTemplate
  autocmd!
  autocmd BufNewFile .gitignore,.npmignore,.tasks,.clang-format,Solution.cpp Template
augroup END







" -----------------------------------------------------------------------------
"  < Vim-plug 插件管理工具配置 >
" -----------------------------------------------------------------------------
" 用于更方便的管理vim插件，具体用法参考 :h plug 帮助
" 安装方法为在终端输入如下命令
" git clone https://github.com/junegunn/vim-plug ~\.vim\vimfiles\autoload
" 如果想在 windows 安装就必需先安装 "git for window"，可查阅网上资料

" 使用vim-plug来管理，这个必须要有。
if g:islinux
    set rtp+=~/.vim/plugged/
    call plug#begin('~/.vim/plugged')
else
    set rtp+=$VIM/vimfiles/plugged/
    call plug#begin('$VIM/vimfiles/plugged')
endif

" 以下为要安装或更新的插件，不同仓库都有（具体书写规范请参考帮助）
Plug 'vim-scripts/a.vim', {'for': ['c', 'cpp']}
Plug 'junegunn/vim-easy-align', {'on': '<Plug>(EasyAlign)'}
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag', {'for': ['html', 'xml']}
Plug 'vim-scripts/cSyntaxAfter'
Plug 'kien/rainbow_parentheses.vim'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'easymotion/vim-easymotion', {'on': ['<Plug>(easymotion-overwin-w)', '<Plug>(easymotion-bd-f)']}
Plug 'mattn/emmet-vim', {'for': ['html','css']}
Plug 'Yggdroot/indentLine'
Plug 'vim-scripts/vim-javacompleteex', {'for': 'java'}
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree',  {'on': 'NERDTreeToggle'}
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/tagbar'
Plug 'vim-scripts/taglist.vim'
Plug 'simnalamburt/vim-mundo', {'on': 'MundoToggle'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Chiel92/vim-autoformat'
Plug 'vim-scripts/repeat.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/ZoomWin'
Plug 'iamcco/mathjax-support-for-mkdp', {'for': 'markdown'}
Plug 'iamcco/markdown-preview.vim', {'for': 'markdown'}
Plug 'yianwillis/vimcdoc'
Plug 'skywind3000/asyncrun.vim', {'on': ['AsyncRun', 'AsyncStop'] }
Plug 'skywind3000/asyncrun.extra'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/vim-dict'
Plug 'voldikss/vim-floaterm'
Plug 'sillybun/vim-repl', {'on': ['REPLToggle', 'REPLDebugStopAtCurrentLine']}
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-fugitive', {'on': ['Gw', 'Gc', 'Gcommit', 'G']}
if has('nvim') || has('patch-8.0.902')
    Plug 'mhinz/vim-signify'
else
    Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
" --------------以下为配色相关插件-------------
Plug 'ayu-theme/ayu-vim'
Plug 'cormacrelf/vim-colors-github'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'lifepillar/vim-solarized8'
Plug 'tomasr/molokai'
Plug 'crusoexia/vim-monokai'
Plug 'KeitaNakamura/neodark.vim'
Plug 'srcery-colors/srcery-vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'rakr/vim-one'
Plug 'joshdick/onedark.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'morhetz/gruvbox'
Plug 'Rigellute/rigel'
Plug 'romainl/Apprentice'
Plug 'nanotech/jellybeans.vim'
Plug 'nightsense/cosmic_latte'
Plug 'yuttie/hydrangea-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'trevordmiller/nova-vim'
Plug 'davidklsn/vim-sialoquent'
Plug 'rakr/vim-two-firewatch'
call plug#end()

" -----------------------------------------------------------------------------
"  < 编码配置 >
" -----------------------------------------------------------------------------
" 注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
set encoding=utf-8                                    "设置gvim内部编码
set fileencoding=utf-8                                "设置当前文件编码
set termencoding=utf-8                                "设置终端编码
set fileencodings=ucs-bom,utf-8,gbk,gb18030,cp936,big5,euc-jp,euc-kr,latin     "设置支持打开的文件的编码
set langmenu=zh_CN.UTF-8                              "启用中文菜单
set helplang=cn                                       "启用中文帮助
let $LANG='en_US.UTF-8'                               "默认语言建议设置成英文
set ambiwidth=single                                 "防止Unicode特殊符号无法显示
" 文件格式，默认 ffs=dos,unix
set fileformat=unix                                   "设置新文件的<EOL>格式
set fileformats=unix,dos,mac                          "给出文件的<EOL>格式类型
if (g:iswindows && g:isGUI)
    "解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    "解决consle输出乱码
    language messages zh_CN.utf-8
endif


" -----------------------------------------------------------------------------
"  < 剪贴板配置 >
" -----------------------------------------------------------------------------
set clipboard+=unnamed                                "默认寄存器和系统剪贴板共享


" -----------------------------------------------------------------------------
"  < 数据文件配置 >
" -----------------------------------------------------------------------------
set history=10000 noswapfile
" 自动拼写检查设置
set nospell
" if g:islinux
    " set spellfile=$HOME/.vim/spell/en.utf-8.add
" else
    " set spellfile=$VIMRUNTIME\spell\en.utf-8.add  "有错，待解决
" endif
"  禁止自动生成备份文件
set nobackup nowritebackup
if g:islinux
    set backupdir=$HOME/.cache/backup_dir
else
    set backupdir=$VIM\cache\backup_dir
endif
" undo设置
set undofile undolevels=1000
if g:islinux
    set undodir=$HOME/.cache/vim/undo_dir
else
    set undodir=$VIM\cache\undo_dir
endif
" -----------------------------------------------------------------------------
"  < 编辑器性能配置 >
" -----------------------------------------------------------------------------
set updatetime=100 timeout timeoutlen=500 ttimeout ttimeoutlen=50 nolazyredraw

" -----------------------------------------------------------------------------
"  < 声音告警配置 >
" -----------------------------------------------------------------------------
" set noerrorbells visualbell t_vb=
set vb t_vb=
au GuiEnter * set t_vb=

" -----------------------------------------------------------------------------
"  < 补全配置 >
" -----------------------------------------------------------------------------
set complete& completeopt=menuone,noinsert infercase pumheight=10 noshowfulltag shortmess+=c

" -----------------------------------------------------------------------------
"  < 搜索配置 >
" -----------------------------------------------------------------------------
set wrapscan ignorecase smartcase incsearch hlsearch magic shortmess-=S


" -----------------------------------------------------------------------------
"  < 编写文件时的配置 >
" -----------------------------------------------------------------------------
set wildmenu                                          "开启命令行菜单列表
set wildmode=list:longest,full                        "开启命令行补全
set autochdir                                         "自动切换目录为当前编辑文件所在目录
set nobomb                                            "不使用bomb标志
set backspace=indent,eol,start                        "允许backspace处理缩进
filetype on                                           "启用文件类型侦测
filetype plugin on                                    "针对不同的文件类型加载对应的插件
filetype plugin indent on                             "启用缩进
set autoindent                                        "自动对齐
set smartindent                                       "启用智能对齐方式
set expandtab                                         "将Tab键转换为空格
set softtabstop=4                                     "第一次tab插入4个空格
set tabstop=4                                         "设置Tab键的宽度
set shiftwidth=4                                      "换行时自动缩进4个空格
set smarttab                                          "指定按一次backspace就删除shiftwidth宽度的空格
set foldenable                                        "启用折叠
" set nofoldenable                                      "不启用折叠
set foldlevel=100                                     "启动vim时不要自动折叠代码
set foldmethod=indent                                 "indent 折叠方式
" set foldmethod=marker                                "marker 折叠方式
set winaltkeys=no                                     "设置alt键不映射到菜单栏
set incsearch                                         "在输入要搜索的文字时，实时匹配
set mouse=a                                           " 在任何模式下启用鼠标
" 启用语法高亮
if has("syntax")
    syntax on
endif
set confirm                                            "处理为保存或只读文件时弹出确认
set viminfo+=!                                         "保存全局变量
set iskeyword+=_,$,@,%,#,-                             "带有指定符号的单词不被换行分割"
set backspace=2                                        "使回格键（backspace）正常处理indent, eol, start等
au BufRead,BufNewFile * setfiletype txt                "高亮txt文件
set autoread                                           "当文件在外部被修改，自动更新该文件
set autowrite                                          "自动保存文件
set hidden                                             "支持未保存的缓冲区跳转


" 用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>



" 比较文件
nmap <C-F2> :vert diffsplit

" 新建标签
map <M-F2> :tabnew<CR>

" 用红色色块显示行尾空格
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" 常规模式下输入 cS 清除行尾空格
nmap cK :%s/\s\+$//g<CR>:noh<CR>

" 常规模式下输入 cM 清除行尾 ^M 符号
nmap cM :%s/\r$//g<CR>:noh<CR>

" 常规模式下输入 cL 清楚文件所有的空行
nmap cL :g/^\s*$/d<CR>

" 在后面的搜索中禁用高亮显示
" removes highlight of your last search
" ``<c>`` stands for ``ctrl`` and therefore ``<c-n>`` stands for ``ctrl+n``
noremap <c-n> :nohl<cr>

" Ctrl + K 插入模式下光标向上移动
imap <c-k> <Up>

" Ctrl + J 插入模式下光标向下移动
imap <c-j> <Down>

" Ctrl + H 插入模式下光标向左移动
imap <c-h> <Left>

" Ctrl + L 插入模式下光标向右移动
imap <c-l> <Right>

" 可用<C-k,j,h,l>切换到上下左右的窗口中去, 包括内置终端
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l
tnoremap <C-h> <C-w><C-h>
tnoremap <C-j> <C-w><C-j>
tnoremap <C-k> <C-w><C-k>
tnoremap <C-l> <C-w><C-l>

" 标签之间的移动
map <M-h> <esc>:tabprevious<cr>
map <M-l> <esc>:tabnext<cr>

" 可视模式下块移动
" try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

" 启用每行超过80列的字符提示（字体变蓝并加下划线），不启用就注释掉
au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)
" set colorcolumn=80

" -----------------------------------------------------------------------------
"  < 界面配置 >
" -----------------------------------------------------------------------------
set number relativenumber                             "显示行号和相对行号
set noshowcmd ruler rulerformat= laststatus=2         "不显示输入的命令和状态栏标尺
set display=lastline,uhex                             "显示设置
set showtabline=2                                     "显示顶部tabline
" 设置括号配对高亮
set showmatch matchtime=0 matchpairs+=<:>,《:》,（:）,【:】,“:”,‘:’
" 设置命令行的高度为1
set showmode cmdheight=1 cmdwinheight=1 showbreak= breakindent breakindentopt=
" 窗口标题设置
set title titlelen=100 titleold= titlestring=%f noicon norightleft
" 突出显示当前行
set cursorline nocursorcolumn colorcolumn= concealcursor=nvc conceallevel=0
" 显示不可见字符
set list listchars=tab:\|\ ,extends:>,precedes:< synmaxcol=3000
" 设置分屏模式、跨行模式、滚屏模式
set nosplitbelow nosplitright nostartofline linespace=0 whichwrap=b,s scrolloff=5 sidescroll=0
" 分割窗口设置
set equalalways winfixwidth winfixheight winminwidth=3 winheight=3 winminheight=3
" 终端设置
set termguicolors cpoptions+=I  nowarn noconfirm
" gui设置
set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:hor20
set go=                                               "不要图形按钮
set guifont=Hack:h12                                  "设置字体:字号（字体名称空格用下划线代替）
" set guifont=Monaco_for_Powerline:h11                  "设置字体:字号（字体名称空格用下划线代替）
" set nowrap                                            "设置不自动换行
set report=0                                          "命令行提示文件哪里被改动
set wrap wrapmargin=0                                 "设置自动换行
set shortmess+=I                                      "去掉欢迎界面
" 显示标号栏
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
" set listchars=tab:▶\ ,eol:¬,trail:·,extends:>,precedes:<     "显示不可见字符
" 设置 gVim 窗口初始位置及大小
if g:isGUI
    " au GUIEnter * simalt ~x                           "窗口启动时自动最大化
    winpos 100 10                                     "指定窗口出现的位置，坐标原点在屏幕左上角
    set lines=38 columns=120                          "指定窗口大小，lines为高度，columns为宽度
endif

" 设置代码配色方案
" if g:isGUI
    " colorscheme Tomorrow-Night-Eighties               "Gvim配色方案
    " colorscheme molokai
    " colorscheme solarized
    " set background=dark
    " set background=light
    " ---------ayu-------------
    " let ayucolor="light"  " for light version of theme
    " let ayucolor="mirage" " for mirage version of theme
    " let ayucolor="dark"   " for dark version of theme
    " colorscheme ayu
    " ---------github-------------
    " colorscheme github
    " let g:github_colors_soft = 1
" else
    " colorscheme Tomorrow-Night-Eighties               "终端配色方案
    " colorscheme molokai
    " colorscheme solarized
    " set background=dark
    " set background=light
    " ---------ayu-------------
    " let ayucolor="light"  " for light version of theme
    " let ayucolor="mirage" " for mirage version of theme
    " let ayucolor="dark"   " for dark version of theme
    " colorscheme ayu
    " ---------github-------------
    " colorscheme github
    " let g:github_colors_soft = 1
" endif

" 每次打开vim自动切换配色方案
let s:guicolor=['solarized8', 'molokai', 'monokai', 'dracula', 'neodark',
            \'srcery', 'cosmic_latte', 'one', 'onedark', 'gruvbox',
            \'hydrangea', 'nord', 'nova', 'two-firewatch',
            \'sialoquent', 'github', 'ayu', 'palenight', 'codedark', 'rigel',
            \'jellybeans']

let s:termcolor=['molokai', 'monokai', 'dracula', 'neodark', 'srcery',
            \'two-firewatch', 'onedark', 'gruvbox', 'palenight',
            \'codedark', 'apprentice', 'jellybeans', 'github',
            \'hydrangea']

set background=dark

function NextColor()
    try
        if has("gui_running")
            let curcolor = localtime() % len(s:guicolor)
            execute 'colorscheme ' .s:guicolor[curcolor]
            execute 'syntax sync fromstart'
        else
            let curcolor = localtime() % len(s:termcolor)
            execute 'colorscheme ' .s:termcolor[curcolor]
            execute 'syntax sync fromstart'
        endif
        catch
    endtry
endfunction

call NextColor()



" 显示/隐藏菜单栏、工具栏、滚动条，可用 Ctrl + F11 切换
if g:isGUI
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set guioptions-=e                                 "使用内置tab样式而不是gui
    map <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
                \set guioptions-=m <Bar>
                \set guioptions-=T <Bar>
                \set guioptions-=r <Bar>
                \set guioptions-=L <Bar>
                \else <Bar>
                \set guioptions+=m <Bar>
                \set guioptions+=T <Bar>
                \set guioptions+=r <Bar>
                \set guioptions+=L <Bar>
                \endif<CR>
endif

" -----------------------------------------------------------------------------
"  < 命令行修正 >
" -----------------------------------------------------------------------------
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class
set wildchar=9 nowildmenu wildmode=longest,full wildmenu wildoptions= wildignorecase fileignorecase
set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib "stuff to ignore when tab completing
set wildignore+=__pycache__,.stversions,*.spl,*.out,%*
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android

" =============================================================================
"                          << 以下为常用插件配置 >>
" =============================================================================


" -----------------------------------------------------------------------------
"  <lightline 插件配置 >
" -----------------------------------------------------------------------------
" 轻量级状态栏插件，更好的状态栏效果
let g:lightline = {
  \ 'colorscheme': 'darcula',
  \ 'active': {
    \ 'left': [
      \ ['mode', 'paste'],
      \ ['fugitive', 'readonly', 'filename', 'Modifyed']
    \ ],
    \ 'right': [
      \ ['asyncrun_status'],
      \ ['lineinfo'],
      \ ['percent'],
      \ ['fileformat', 'fileencoding'],
      \ ['filetype']
    \ ]
  \ },
  \ 'inactive': {
    \ 'left': [['inactive_fileinfo']],
    \ 'right': []
  \ },
  \ 'tabline': {
    \ 'left': [['vim_logo', 'buffers']],
    \ 'right': [['close']]
  \ },
  \ 'component': {
    \ 'lineinfo': ' %l,%-v',
    \ 'percent': '%p%%',
    \ 'close': '%{has("nvim") ? " NVIM " : " VIM "}',
    \ 'vim_logo': "#"
  \ },
  \ 'component_expand': { 'buffers': 'lightline#bufferline#buffers' },
  \ 'component_type': { 'buffers': 'tabsel' }
\ }

" -----------------------------------------------------------------------------
"  <lightline-bufferline 插件配置 >
" -----------------------------------------------------------------------------
" 采用lightline风格，在窗口顶部显示buff列表的模块
" mengelbrecht/lightline-bufferline
let g:lightline#bufferline#unnamed = '[No Name]'
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#unicode_symbols = 1
let g:lightline#bufferline#show_number  = 3
let g:lightline#bufferline#number_map = {
      \ 0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
      \ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'
      \ }
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)

" -----------------------------------------------------------------------------
"  < a.vim 插件配置 >
" -----------------------------------------------------------------------------
" 用于切换C/C++头文件
" :A     ---切换头文件并独占整个窗口
" :AV    ---切换头文件并垂直分割窗口
" :AS    ---切换头文件并水平分割窗口

" -----------------------------------------------------------------------------
"  < vim-easy-align 插件配置 >
" -----------------------------------------------------------------------------
" https://github.com/junegunn/vim-easy-align
" 一个对齐的插件，用来排版与对齐代码，功能强大
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" -----------------------------------------------------------------------------
"  < auto-pairs 插件配置 >
" -----------------------------------------------------------------------------
" 用于括号与引号自动补全，不过会与函数原型提示插件echofunc冲突
" 所以我就没有加入echofunc插件

" -----------------------------------------------------------------------------
"  < vim-closetag插件配置 >
" -----------------------------------------------------------------------------
" html文件自动闭合标签


" -----------------------------------------------------------------------------
"  < cSyntaxAfter 插件配置 >
" -----------------------------------------------------------------------------
" 高亮括号与运算符等
au! BufRead,BufNewFile,BufEnter *.{c,cpp,h,py,lua,java,javascript} call CSyntaxAfter()


" -----------------------------------------------------------------------------
"  < rainbow_parentheses.vim 插件配置 >
" -----------------------------------------------------------------------------
" 给括号增加颜色
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
" -----------------------------------------------------------------------------
"  <  LeaderF插件配置 >
" -----------------------------------------------------------------------------
" 一个异步全路径模糊文件，缓冲区，函数检索插件；详细帮助见 :h leaderf.txt
" 常规模式下输入：<leader>f 搜索文件，<leader>b 搜索缓冲区
" <C-C>, <ESC> : 退出 LeaderF.
" <C-R> : 在模糊匹配和正则式匹配之间切换
" <C-F> : 在全路径搜索和名字搜索之间切换
" <i/Tab> : 在检索模式和选择模式之间切换
" <C-J>, <C-K> : 在结果列表里选择
" <X> : 在水平窗口打开
" <V> : 在垂直窗口打开
" <T> : 在新标签打开
" <S> : 多选文件
" <A> : 选择所有文件
" <C> : 清除文件选择
" <P> : 预览结果
" <C-O> : 预览返回
" <Q> : 退出
" <F1>: 选择模式下显示帮助
" <F5>: 刷新缓存

" 设置快捷键
" let g:Lf_ShortcutF = "<leader>fa"
noremap <silent> <leader>ff :<C-U><C-R>=printf("Leaderf file %s", "")<CR><CR>
noremap <silent> <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <silent> <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <silent> <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <silent> <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
noremap <silent> <leader>fu :<C-U><C-R>=printf("Leaderf function %s", "")<CR><CR>
noremap <silent> <leader>fh :<C-U><C-R>=printf("Leaderf cmdHistory %s", "")<CR><CR>
noremap <silent> <leader>fr :<C-U><C-R>=printf("Leaderf rg %s", "")<CR><CR>
noremap <silent> <leader>fc :<C-U>Leaderf! --recall --stayOpen<CR>

" 从当前buff中搜索光标所在行的内容
noremap <silent> <leader>fi :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
" 从当前目录所有文件中搜索当前光标所在行的内容
noremap <silent> <leader>fa :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" 可视模式下在当前目录下所有文件中搜索选择内容
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>

" 支持function选项可以搜索python的class
let g:Lf_CtagsFuncOpts = {"python": "--python-kinds=fmc --language-force=Python"}
" 设置项目根目录标识
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
" 定义leaderf的工作目录
let g:Lf_WorkingDirectoryMode = 'Ac'
" 定义leader窗口的高度，小于1表示百分比
let g:Lf_WindowHeight = 0.30
" 不使用使用缓冲
let g:Lf_UseCache = 0
" 设置缓存目录
if g:islinux
    let g:Lf_CacheDirectory = expand('~/.vim/cache')
else
    let g:Lf_CacheDirectory = expand('$VIM/cache')
endif
" 显示相对路径
let g:Lf_ShowRelativePath = 0
" 颜色模板
let g:Lf_StlColorscheme = 'powerline'
" 在正常模式下不显示帮助
let g:Lf_HideHelp = 1
let g:Lf_UseVersionControlTool = 0
" 忽略当前buff名称
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
" 使用弹出式窗口
" let g:Lf_WindowPosition = 'popup'
" 在弹出式窗口中预览
" let g:Lf_PreviewInPopup = 1
" 设置状态栏提示和字体
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
" 隐藏函数列表的预览功能
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
" 使用ESC键退出函数列表
let g:Lf_NormalMap = {
            \ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
            \ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>']],
            \ "Mru":    [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>']],
            \ "Tag":    [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<CR>']],
            \ "Function":    [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<CR>']],
            \ "Colorscheme":    [["<ESC>", ':exec g:Lf_py "colorschemeExplManager.quit()"<CR>']],
            \ }
" -----------------------------------------------------------------------------
"  <  vim-easymotion插件配置 >
" -----------------------------------------------------------------------------
" 快速移动光标插件
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
map <silent> <Space>f <Plug>(easymotion-overwin-w)
map <silent> <Space>F <Plug>(easymotion-bd-f)

" -----------------------------------------------------------------------------
"  <  vim-fugitive插件配置 >
" -----------------------------------------------------------------------------
" vim中使用Git命令的插件
" :Git 命令行格式


" -----------------------------------------------------------------------------
"  <  vim-signify插件配置 >
" -----------------------------------------------------------------------------
"  在屏幕左侧显示Git变更的支持插件
"  自动更新频率设置


" -----------------------------------------------------------------------------
"  < emmet-vim（前身为Zen coding） 插件配置 >
" -----------------------------------------------------------------------------
" HTML/CSS代码快速编写神器

" -----------------------------------------------------------------------------
"  < indentLine 插件配置 >
" -----------------------------------------------------------------------------
" 用于显示对齐线，与 indent_guides 在显示方式上不同，根据自己喜好选择了
" 在终端上会有屏幕刷新的问题，这个问题能解决有更好了
let g:indentLine_char = '│'
let g:indentLine_enabled = 1
let g:indentLine_color_term = 238
let g:indentLine_fileTypeExclude = [
      \ 'coc-explorer',
      \ 'codi',
      \ 'floaterm',
      \ 'help',
      \ 'json',
      \ 'jsonc',
      \ 'man',
      \ 'startify',
      \ 'translator',
      \ 'vista',
      \ ]

" -----------------------------------------------------------------------------
"  < vim-javacompleteex（也就是 javacomplete 增强版）插件配置 >
" -----------------------------------------------------------------------------
" java 补全插件


" -----------------------------------------------------------------------------
"  < coc.nvim 插件配置 >
" -----------------------------------------------------------------------------
if g:islinux
    let g:coc_data_home = '$HOME/.vim/coc'
else
    let g:coc_data_home = '$VIM/vimfiles/coc'
endif
nnoremap <silent><nowait> <C-b> :call fn#keymap#n#scroll_win(0)<CR>
nnoremap <silent><nowait> <C-f> :call fn#keymap#n#scroll_win(1)<CR>
inoremap <silent><nowait><expr> <C-f>
      \ coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" :
      \ "<C-r>=fn#keymap#exec('normal! w')<CR>"
inoremap <silent><nowait><expr> <C-b>
      \ coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" :
      \ "<C-r>=fn#keymap#exec('normal! b')<CR>"
nnoremap <expr> <silent> <C-c> <SID>select_current_word_and_go_next()
function! s:select_current_word_and_go_next()
  if !get(g:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  " based on coc readme, this has been modified
  " because I have mapped * to m`:keepjumps normal! *``zz<cr>
  return "*n\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc
nmap     <silent> <M-n>      <Plug>(coc-diagnostic-next)
nmap     <silent> <M-p>      <Plug>(coc-diagnostic-prev)
nnoremap <silent> cl         :<C-u>CocList<CR>
nnoremap <silent> <Leader>cs :<C-u>CocSearch <C-r><C-w><CR>
nmap     <silent> <Leader>cf <Plug>(coc-fix-current)
nmap     <silent> <Leader>cd <Plug>(coc-definition)
nmap     <silent> <Leader>cr <Plug>(coc-refactor)
nmap     <silent> <Leader>ci <Plug>(coc-implementation)
nmap     <silent> <Leader>rn <Plug>(coc-rename)
nmap     <silent> <Leader>rf <Plug>(coc-references-used)
nnoremap <silent> <Leader>rs :<C-u>CocRestart<CR>
xmap if <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-a)
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
" coc-git
nnoremap <silent> gs  :CocCommand git.chunkStage<CR>
nnoremap <silent> go  :CocCommand git.browserOpen<CR>
nnoremap <silent> gd  :CocCommand git.chunkInfo<CR>
nnoremap <silent> gm  :CocCommand git.showCommit<CR>
nnoremap <silent> gw  :call fn#file#refresh()<CR>:Gw<CR>:call fn#file#refresh()<CR>
nnoremap <silent> gW  :AsyncRun -cwd=<root> -silent=1 git add .<CR>
nnoremap <silent> gca :Gcommit --amend -v<CR>
nnoremap <silent> gcm :Gcommit -v<CR>
nnoremap <silent> gcu :CocCommand git.chunkUndo<CR>:call timer_start(50, {->execute('update')})<CR>
" coc-snippets
" 不要改动
inoremap <silent><expr> <TAB>
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_snippet_next = '<tab>'
" coc extensions
let g:coc_global_extensions = [
      \ 'coc-browser',
      \ 'coc-css',
      \ 'coc-diagnostic',
      \ 'coc-dictionary',
      \ 'coc-ecdict',
      \ 'coc-emmet',
      \ 'coc-emoji',
      \ 'coc-eslint',
      \ 'coc-explorer',
      \ 'coc-floaterm',
      \ 'coc-gist',
      \ 'coc-git',
      \ 'coc-highlight',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-just-complete',
      \ 'coc-leetcode',
      \ 'coc-lists',
      \ 'coc-marketplace',
      \ 'coc-pairs',
      \ 'coc-prettier',
      \ 'coc-pyright',
      \ 'coc-python',
      \ 'coc-syntax',
      \ 'coc-snippets',
      \ 'coc-tag',
      \ 'coc-tasks',
      \ 'coc-todolist',
      \ 'coc-translator',
      \ 'coc-tslint-plugin',
      \ 'coc-tsserver',
      \ 'coc-vimlsp',
      \ 'coc-vimtex',
      \ 'coc-word',
      \ 'coc-yank'
      \ ]


" -----------------------------------------------------------------------------
"  < vim-autoformat 插件配置 >
" -----------------------------------------------------------------------------
" 各种编程语言的自动格式化插件
" 添加一键格式化
noremap <c-p> :Autoformat<cr>
" let g:autoformat_autoindent = 0
" let g:autoformat_retab = 0
" let g:autoformat_remove_trailing_spaces = 0

" -----------------------------------------------------------------------------
"  < nerdcommenter 插件配置 >
" -----------------------------------------------------------------------------
" 我主要用于C/C++代码注释(其它的也行)
" 以下为插件默认快捷键，其中的说明是以C/C++为例的，其它语言类似
" <Leader>ci 以每行一个 /* */ 注释选中行(选中区域所在行)，再输入则取消注释
" <Leader>cm 以一个 /* */ 注释选中行(选中区域所在行)，再输入则称重复注释
" <Leader>cc 以每行一个 /* */ 注释选中行或区域，再输入则称重复注释
" <Leader>cu 取消选中区域(行)的注释，选中区域(行)内至少有一个 /* */
" <Leader>ca 在/*...*/与//这两种注释方式中切换（其它语言可能不一样了）
" <Leader>cA 行尾注释
let NERDSpaceDelims = 1                     "在左注释符之后，右注释符之前留有空格

" -----------------------------------------------------------------------------
"  < nerdtree 插件配置 >
" -----------------------------------------------------------------------------
" 有目录村结构的文件浏览插件

" 常规模式下输入 F2 调用插件
nmap <F2> :NERDTreeToggle<CR>
" let g:NERDTreeDirArrowExpandable = '|'
" let g:NERDTreeDirArrowCollapsible = '+'
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeShowHidden=1
let g:NERDTreeWinSize=40
let g:netrw_dirhistmax = 0
" let g:netrw_home='~/.cache/vim'

if g:islinux
    let g:netrw_home=expand("$HOME/.cache/nerdtree_dir")
else
    let g:netrw_home=expand("$VIM/cache/nerdtree_dir")
endif

" -----------------------------------------------------------------------------
"  < vim-devicons 插件配置 >
" -----------------------------------------------------------------------------
" 支持VIM显示各类标志符号（图标）
" 要求使用nerd系列字体

" -----------------------------------------------------------------------------
"  < repeat 插件配置 >
" -----------------------------------------------------------------------------
" 主要用"."命令来重复上次插件使用的命令

" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
"  < UltiSnips 插件配置 >
" -----------------------------------------------------------------------------
" 用于各种代码补全，这种补全是一种对代码中的词与代码块的缩写补全，详细用法可以参
" 考使用说明或网络教程等。不过有时候也会与 supertab 插件在补全时产生冲突，如果大
" 侠有什么其它解决方法希望不要保留呀
let g:UltiSnipsExpandTrigger="<tab>"
" 使用 tab 切换下一个触发点，shit+tab 上一个触发点
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
" 使用 UltiSnipsEdit 命令时垂直分割屏幕
let g:UltiSnipsEditSplit="vertical"

" -----------------------------------------------------------------------------
"  < vim-snippets 插件配置 >
" -----------------------------------------------------------------------------
"  UltiSnips使用的补全模板插件，配合UltiSnips使用，必须安装。
"  具体配置查看vim-snippets目录下的UltiSnips目录中相应文件类型的配置文件。


" -----------------------------------------------------------------------------
"  < surround 插件配置 >
" -----------------------------------------------------------------------------
" 快速给单词/句子两边增加符号（包括html标签），缺点是不能用"."来重复命令
" 不过 repeat 插件可以解决这个问题，详细帮助见 :h surround.txt


" -----------------------------------------------------------------------------
"  < Tagbar 插件配置 >
" -----------------------------------------------------------------------------
" 相对 TagList 能更好的支持面向对象

" 常规模式下输入 tb 调用插件，如果有打开 TagList 窗口则先将其关闭
nmap tb :TlistClose<CR>:TagbarToggle<CR>

let g:tagbar_width=30                       "设置窗口宽度
" let g:tagbar_left=1                         "在左侧窗口中显示

" -----------------------------------------------------------------------------
"  < TagList 插件配置 >
" -----------------------------------------------------------------------------
" 高效地浏览源码, 其功能就像vc中的workpace
" 那里面列出了当前文件中的所有宏,全局变量, 函数名等

" 常规模式下输入 tl 调用插件，如果有打开 Tagbar 窗口则先将其关闭
nmap tl :TagbarClose<CR>:Tlist<CR>

let Tlist_Show_One_File=1                   "只显示当前文件的tags
" let Tlist_Enable_Fold_Column=0              "使taglist插件不显示左边的折叠行
let Tlist_Exit_OnlyWindow=1                 "如果Taglist窗口是最后一个窗口则退出Vim
let Tlist_File_Fold_Auto_Close=1            "自动折叠
let Tlist_WinWidth=30                       "设置窗口宽度
let Tlist_Use_Right_Window=1                "在右侧窗口中显示

" -----------------------------------------------------------------------------
"  < vim-mundo 插件配置 >
" -----------------------------------------------------------------------------
" 可视化撤销树插件
noremap  <silent> <F4>             <Esc>:MundoToggle<CR>
noremap! <silent> <F4>             <Esc>:MundoToggle<CR>
tnoremap <silent> <F4>             <C-\><C-n>:MundoToggle<CR>
let g:mundo_width              = 30
let g:mundo_preview_height     = 10
let g:mundo_right              = 0
let g:mundo_preview_bottom     = 1
let g:mundo_auto_preview_delay = 10


" -----------------------------------------------------------------------------
"  < vim-dict 插件配置 >
" -----------------------------------------------------------------------------
" 根据文件类型自动将字典文件添加到当前缓冲区
" 添加其他字典文件夹
" let g:vim_dict_dict = [
    " \ '~/.vim/dict',
    " \ '~/.config/nvim/dict',
    " \ ]
" 文件类型覆盖
let g:vim_dict_config = {'html':'html,javascript,css', 'markdown':'text'}
" 禁用某些文件类型
" let g:vim_dict_config = {'text': ''}

" -----------------------------------------------------------------------------
"  < AsyncRun 插件配置 >
" -----------------------------------------------------------------------------
" 插件主页：https://github.com/skywind3000/asyncrun.vim
" 是AsyncTasks插件依赖此插件。
" 利用Vim8的异步执行优势，在后台运行shell命令并实时在quickfix窗口中读取输出
" 通过:AsyncRun （就像旧的!cmd一样）启动后台命令，无需等待，可以同时干其他事情
" 输出显示在quickfix窗口中，可立即查看错误输出。
" 异步执行命令例子：:AsyncRun git push origin master
" 关闭正在执行的程序例子：:AsyncStop [!]
let g:asyncrun_status = ''  " asyncrun被延迟加载
let g:asyncrun_open= 9       "打开高度为6的quickfix窗口，或者可以:copen打开
" 标记项目根目录
let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.tasks', '.project', '.hg']

" -----------------------------------------------------------------------------
"  < AsyncRun.extra 插件配置 >
" -----------------------------------------------------------------------------
" 异步运行输出到其他种类的窗口中
" -----------------------------------------------------------------------------
"  < AsyncTasks 插件配置 >
" -----------------------------------------------------------------------------
"  插件主页：https://github.com/skywind3000/asynctasks.vim
"  一套优雅的通用的任务系统来加速你的内部开发循环（编辑，编译，测试）。
"  这应该是目前 Vim 下最强的构建工具
"  asynctasks在每个项目的根文件夹下面放一个 .tasks 来描述针对该项目的局部任务，
"  同时维护一份 ~/.vim/tasks.ini 的全局任务配置，适配一些通用性很强的项目，
"  避免每个项目重复写 .tasks 配置。
"  项目依赖 asyncrun.vim 项目 2.4.0 及以上版本
"  :AsyncTaskEdit命令编辑当前项目或当前目录的.tasks配置文件
"  :AsyncTaskEdit! 命令编辑全局任务
"  :AsyncTaskList 查询当前项目下的可用任务:AsyncTaskList! 查询所有任务
"  :AsyncTaskMacro 命令查看所有内部宏的对应关系
" 运行当前文件
" nnoremap <silent> <F6> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
" 使用floaterm窗口运行
noremap <silent><f5> :AsyncTask start<cr>
" 使用vim terminal窗口运行
" noremap <silent><f5> :AsyncTask file-run<cr>
" 编译当前文件
" nnoremap <silent> <F9> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
noremap <silent><f9> :AsyncTask file-build<cr>
" 运行当前项目
" nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make run <cr>
noremap <silent><f8> :AsyncTask project-run<cr>
" 编译当前项目
" nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr>
noremap <silent><f7> :AsyncTask project-build<cr>
" 内置终端位置设置
let g:asynctasks_term_pos = 'bottom'

" -----------------------------------------------------------------------------
"  < vim-floaterm 插件配置 >
" -----------------------------------------------------------------------------
nnoremap   <silent>  <leader>tn    :FloatermNew<CR>
tnoremap   <silent>  <leader>tn    <C-\><C-n>:FloatermNew<CR>
nnoremap   <silent>  <leader>th    :FloatermPrev<CR>
tnoremap   <silent>  <leader>th    <C-\><C-n>:FloatermPrev<CR>
nnoremap   <silent>  <leader>tl    :FloatermNext<CR>
tnoremap   <silent>  <leader>tl    <C-\><C-n>:FloatermNext<CR>
nnoremap   <silent>  <leader>tt   :FloatermToggle<CR>
tnoremap   <silent>  <leader>tt   <C-\><C-n>:FloatermToggle<CR>
nnoremap   <silent>  <leader>tk   :FloatermKill<CR>
tnoremap   <silent>  <leader>tk   <C-\><C-n>:FloatermKill<CR>
nnoremap   <silent>  <leader>ts   :FloatermSend<CR>
vnoremap   <silent>  <leader>ts   :FloatermSend<CR>
hi FloatermBorder guifg = orange
hi link FloatermBorder Normal
" noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
noremap <silent><leader>tr :FloatermNew --width=0.5 --wintype=vsplit --name=repl --position=rightbelow ipython<CR>
let g:floaterm_gitcommit     = 'floaterm'
let g:floaterm_autoinsert    = 1
let g:floaterm_width         = 0.5
let g:floaterm_height        = 0.5
let g:floaterm_autoclose     = 1
let g:floaterm_title         = 'floaterm: $1/$2'
let g:floaterm_wintype       = 'popup'
let g:floaterm_position      = 'bottomright'


" -----------------------------------------------------------------------------
"  < vim-repl 插件配置 >
" -----------------------------------------------------------------------------
" python调试插件，建议安装ipython，如需debug，需安装ipdb，
" <leader>r 打开和关闭语言运行环境
" <leader>w 将文件中的语句传送给运行环境
let g:repl_program = {
            \   'python': 'ipython',
            \   'default': 'zsh',
            \   'r': 'R',
            \   'lua': 'lua',
            \   'vim': 'vim -e',
            \   }
let g:repl_predefine_python = {
            \   'numpy': 'import numpy as np',
            \   'matplotlib': 'from matplotlib import pyplot as plt'
            \   }
let g:repl_cursor_down = 1
let g:repl_python_automerge = 1
let g:repl_ipython_version = '7'
let g:repl_output_copy_to_register = "t"
nnoremap <leader>r :REPLToggle<Cr>
nnoremap <leader>e :REPLSendSession<Cr>
autocmd Filetype python nnoremap <F12> <Esc>:REPLDebugStopAtCurrentLine<Cr> "设置断点
autocmd Filetype python nnoremap <F10> <Esc>:REPLPDBN<Cr> "单行运行
autocmd Filetype python nnoremap <F11> <Esc>:REPLPDBS<Cr> "单行运行可跳入
let g:repl_position = 3                             "窗口位置，0底部，1顶部，2左边，3右边"
" let g:repl_width = None                           "窗口宽度
" let g:repl_height = None                          "窗口高度
let g:sendtorepl_invoke_key = "<leader>w"          "传送代码快捷键，默认为<leader>w
let g:repl_position = 3                             "0表示出现在下方，1表示出现在上方，2在左边，3在右边
let g:repl_stayatrepl_when_open = 0         "打开REPL时是回到原文件（1）还是停留在REPL窗口中（0）

" -----------------------------------------------------------------------------
"  < vim-gutentags 插件配置 >
" -----------------------------------------------------------------------------
"  异步自动索引工具，通过ctags自动生成索引
" - 确定文件所属的工程目录，即文件当前路径向上递归查找是否有 `.git`, `.svn`, `.project` 等标志性文件（可以自定义）来确定当前文档所属的工程目录。
" - 检测同一个工程下面的文件改动，能会自动增量更新对应工程的 `.tags` 文件。每次改了几行不用全部重新生成，并且这个增量更新能够保证 `.tags` 文件的符号排序，方便 Vim 中用二分查找快速搜索符号。
" - 你可以在你的野文件目录中放一个名字为 .root 的空白文件，主动告诉 gutentags 这里就是工程目录。

" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = 'tags'
"同时开启ctags和gtags支持
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
if g:islinux
    let s:vim_tags = expand('~/.cache/tags_dir')
else
    let s:vim_tags = expand('$VIM/cache/tags_dir')
endif
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0


" -----------------------------------------------------------------------------
"  < markdown-preview and markdown-support-for-mkdp插件配置 >
" -----------------------------------------------------------------------------
" 通过浏览器实时预览markdown文件
" MarkdownPerview 打开预览窗口
" MarkdownPerviewStop 关闭预览窗口
" markdown-support-for-mkdp 支持预览数学公式
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
"  < ZoomWin 插件配置 >
" -----------------------------------------------------------------------------
" 用于分割窗口的最大化与还原
" 常规模式下按快捷键 <c-w>o 在最大化与还原间切换

" =============================================================================
"                          << 以下为常用工具配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < ctags 工具配置 >
" -----------------------------------------------------------------------------
" 符号索引配置
" set tags=./.tags;,.tags
set tags=./tags,tags,.tags,.vim/tags,.vim/.tags tagfunc=CocTagFunc


" -----------------------------------------------------------------------------
"  < 编译、连接、运行配置 > 老配置，暂时保留，注释掉热键
" -----------------------------------------------------------------------------
" F9 一键保存、编译、连接存并运行
" map <F9> :call Run()<CR>
" imap <F9> <ESC>:call Run()<CR>

" Ctrl + F9 一键保存并编译
" map <c-F9> :call Compile()<CR>
" imap <c-F9> <ESC>:call Compile()<CR>

" Ctrl + F10 一键保存并连接
" map <c-F10> :call Link()<CR>
" imap <c-F10> <ESC>:call Link()<CR>

let s:LastShellReturn_C = 0
let s:LastShellReturn_L = 0
let s:ShowWarning = 1
let s:Obj_Extension = '.o'
let s:Exe_Extension = '.exe'
let s:Class_Extension = '.class'
let s:Sou_Error = 0

let s:windows_CFlags = 'gcc\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
let s:linux_CFlags = 'gcc\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'

let s:windows_CPPFlags = 'g++\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
let s:linux_CPPFlags = 'g++\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'

let s:JavaFlags = 'javac\ %'

func! Compile()
    exe ":ccl"
    exe ":update"
    let s:Sou_Error = 0
    let s:LastShellReturn_C = 0
    let Sou = expand("%:p")
    let v:statusmsg = ''
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let Obj = expand("%:p:r").s:Obj_Extension
        let Obj_Name = expand("%:p:t:r").s:Obj_Extension
        if !filereadable(Obj) || (filereadable(Obj) && (getftime(Obj) < getftime(Sou)))
            redraw!
            if expand("%:e") == "c"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CFlags
                else
                    exe ":setlocal makeprg=".s:linux_CFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CPPFlags
                else
                    exe ":setlocal makeprg=".s:linux_CPPFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            endif
            redraw!
            if v:shell_error != 0
                let s:LastShellReturn_C = v:shell_error
            endif
            if g:iswindows
                if s:LastShellReturn_C != 0
                    exe ":bo cope"
                    echohl WarningMsg | echo " compilation failed"
                else
                    if s:ShowWarning
                        exe ":bo cw"
                    endif
                    echohl WarningMsg | echo " compilation successful"
                endif
            else
                if empty(v:statusmsg)
                    echohl WarningMsg | echo " compilation successful"
                else
                    exe ":bo cope"
                endif
            endif
        else
            echohl WarningMsg | echo ""Obj_Name"is up to date"
        endif
    elseif expand("%:e") == "java"
        let class = expand("%:p:r").s:Class_Extension
        let class_Name = expand("%:p:t:r").s:Class_Extension
        if !filereadable(class) || (filereadable(class) && (getftime(class) < getftime(Sou)))
            redraw!
            exe ":setlocal makeprg=".s:JavaFlags
            echohl WarningMsg | echo " compiling..."
            silent make
            redraw!
            if v:shell_error != 0
                let s:LastShellReturn_C = v:shell_error
            endif
            if g:iswindows
                if s:LastShellReturn_C != 0
                    exe ":bo cope"
                    echohl WarningMsg | echo " compilation failed"
                else
                    if s:ShowWarning
                        exe ":bo cw"
                    endif
                    echohl WarningMsg | echo " compilation successful"
                endif
            else
                if empty(v:statusmsg)
                    echohl WarningMsg | echo " compilation successful"
                else
                    exe ":bo cope"
                endif
            endif
        else
            echohl WarningMsg | echo ""class_Name"is up to date"
        endif
    else
        let s:Sou_Error = 1
        echohl WarningMsg | echo " please choose the correct source file"
    endif
    exe ":setlocal makeprg=make"
endfunc

func! Link()
    call Compile()
    if s:Sou_Error || s:LastShellReturn_C != 0
        return
    endif
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let s:LastShellReturn_L = 0
        let Sou = expand("%:p")
        let Obj = expand("%:p:r").s:Obj_Extension
        if g:iswindows
            let Exe = expand("%:p:r").s:Exe_Extension
            let Exe_Name = expand("%:p:t:r").s:Exe_Extension
        else
            let Exe = expand("%:p:r")
            let Exe_Name = expand("%:p:t:r")
        endif
        let v:statusmsg = ''
        if filereadable(Obj) && (getftime(Obj) >= getftime(Sou))
            redraw!
            if !execurable(Exe) || (executable(Exe) && getftime(Exe) < getftime(Obj))
                if expand("%:e") == "c"
                    setlocal makeprg=gcc\ -o\ %<\ %<.o
                    echohl WarningMsg | echo " linking..."
                    silent make
                elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                    setlocal makeprg=g++\ -o\ %<\ %<.o
                    echohl WarningMsg | echo " linking..."
                    silent make
                endif
                redraw!
                if v:shell_error != 0
                    let s:LastShellReturn_L = v:shell_error
                endif
                if g:iswindows
                    if s:LastShellReturn_L != 0
                        exe ":bo cope"
                        echohl WarningMsg | echo " linking failed"
                    else
                        if s:ShowWarning
                            exe ":bo cw"
                        endif
                        echohl WarningMsg | echo " linking successful"
                    endif
                else
                    if empty(v:statusmsg)
                        echohl WarningMsg | echo " linking successful"
                    else
                        exe ":bo cope"
                    endif
                endif
            else
                echohl WarningMsg | echo ""Exe_Name"is up to date"
            endif
        endif
        setlocal makeprg=make
    elseif expand("%:e") == "java"
        return
    endif
endfunc

func! Run()
    let s:ShowWarning = 0
    call Link()
    let s:ShowWarning = 1
    if s:Sou_Error || s:LastShellReturn_C != 0 || s:LastShellReturn_L != 0
        return
    endif
    let Sou = expand("%:p")
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let Obj = expand("%:p:r").s:Obj_Extension
        if g:iswindows
            let Exe = expand("%:p:r").s:Exe_Extension
        else
            let Exe = expand("%:p:r")
        endif
        if executable(Exe) && getftime(Exe) >= getftime(Obj) && getftime(Obj) >= getftime(Sou)
            redraw!
            echohl WarningMsg | echo " running..."
            if g:iswindows
                exe ":!%<.exe"
            else
                if g:isGUI
                    exe ":!gnome-terminal -x bash -c './%<; echo; echo 请按 Enter 键继续; read'"
                else
                    exe ":!clear; ./%<"
                endif
            endif
            redraw!
            echohl WarningMsg | echo " running finish"
        endif
    elseif expand("%:e") == "java"
        let class = expand("%:p:r").s:Class_Extension
        if getftime(class) >= getftime(Sou)
            redraw!
            echohl WarningMsg | echo " running..."
            if g:iswindows
                exe ":!java %<"
            else
                if g:isGUI
                    exe ":!gnome-terminal -x bash -c 'java %<; echo; echo 请按 Enter 键继续; read'"
                else
                    exe ":!clear; java %<"
                endif
            endif
            redraw!
            echohl WarningMsg | echo " running finish"
        endif
    endif
endfunc

" -----------------------------------------------------------------------------
"  < gvimfullscreen 工具配置 > 请确保已安装了工具
" -----------------------------------------------------------------------------
" 用于 Windows Gvim 全屏窗口，可用 F11 切换
" 全屏后再隐藏菜单栏、工具栏、滚动条效果更好
if (g:iswindows && g:isGUI)
    map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
endif

" -----------------------------------------------------------------------------
"  < vimtweak 工具配置 > 请确保以已装了工具
" -----------------------------------------------------------------------------
" 这里只用于窗口透明与置顶
" 常规模式下 Ctrl + Up（上方向键） 增加不透明度，Ctrl + Down（下方向键） 减少不透明度，<Leader>t 窗口置顶与否切换
" 自动调节透明度
" au GUIEnter * call libcallnr("vimtweak.dll", "SetAlpha", 200)
" 随时调节透明度
if (g:iswindows && g:isGUI)
    let g:Current_Alpha = 255
    let g:Top_Most = 0
    func! Alpha_add()
        let g:Current_Alpha = g:Current_Alpha + 10
        if g:Current_Alpha > 255
            let g:Current_Alpha = 255
        endif
        call libcallnr("vimtweak.dll","SetAlpha",g:Current_Alpha)
    endfunc
    func! Alpha_sub()
        let g:Current_Alpha = g:Current_Alpha - 10
        if g:Current_Alpha < 155
            let g:Current_Alpha = 155
        endif
        call libcallnr("vimtweak.dll","SetAlpha",g:Current_Alpha)
    endfunc
    func! Top_window()
        if  g:Top_Most == 0
            call libcallnr("vimtweak.dll","EnableTopMost",1)
            let g:Top_Most = 1
        else
            call libcallnr("vimtweak.dll","EnableTopMost",0)
            let g:Top_Most = 0
        endif
    endfunc

    "快捷键设置
    map <c-up> :call Alpha_add()<CR>
    map <c-down> :call Alpha_sub()<CR>
    map <leader>t :call Top_window()<CR>
endif
