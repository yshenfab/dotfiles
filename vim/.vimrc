" For neovim do: 
" ln -s ~/.vim ~/.config/nvim
" ln -s ~/.vimrc ~/.config/nvim/init.vim
set nocompatible
execute pathogen#infect()

" Basic Config
filetype plugin indent on
syntax on
set number
set encoding=utf-8

" Indent settings
set autoindent
set cinoptions=l1,p0,)50,*50,t0
set expandtab "use spaces instead of tabs
set smarttab
set softtabstop=4 "Tab key indents by 4 spaces
set shiftwidth=4 ">> indents by 4 spaces
set shiftround ">> indents to next multiple of 'shiftwidth'

" backup/swap/info/undo settings
set nobackup
set nowritebackup
set undofile
set swapfile
" set backupdir=$HOME/.vim/files/backup/
" set directory=$HOME/.vim/files/swap//
" set undodir=$HOME/.vim/files/undo/
" set viewdir=$HOME/.vim/files/view
" set viminfo=%,<800,'10,/50,:100,h,f0,n~/.vim/files/info/viminfo

" Navigation
set cursorline
set foldmethod=marker
set foldopen-=hor
set foldopen+=jump
set foldtext=mhi#foldy()
set incsearch "highlight while searing with / or ?
set hlsearch "keep match highlighted
set mouse=a
set scrolloff=4
set sidescroll=5
set ignorecase
set smartcase
set tagcase=match
" nnoremap <C-Left> :tabprevious<CR>
" nnoremap <C-Right> :tabnext<CR>

" Miscellaneous settings
set autoread
set backspace=indent,eol,start
set clipboard=unnamed
set complete-=i
set completeopt+=noselect
"set diffopt+=vertical,foldcolumn:0,indent-heuristic,algorithm:patience
set fileformats=unix,dos,mac
set hidden "switch between buffers without having to save first
set history=1000
set lazyredraw " only redraw when necessary
set more
set mousemodel=popup
set noautowrite
set noautowriteall
set noequalalways
set noerrorbells
set nofsync
set nojoinspaces
set wrapscan "searches wrap around end-of-file
set nrformats=hex
set pastetoggle=<F5>
set norelativenumber
set report=0 "always report changed lines
set sessionoptions-=options
set sessionoptions+=localoptions
set showfulltag
set showtabline=1
set splitbelow "open new windows below current window
set splitright "open new windows below current window
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set switchbuf=
set synmaxcol=200 "only highlight the first 200 columns 
set tags ^=./.git/tags;
" set timeout
" set timeoutlen=10
set ttyfast " faster redraw
set virtualedit=onemore,block
set whichwrap=h,l

" Display settings
set display+=lastline
set laststatus=2 "always show statusline
set list
set modeline
set modelines=1
set nostartofline
set numberwidth=1
set ruler
set shortmess=aoOTI
set showcmd "show already typed keys when more are expected
set showmatch
set showmode "show current mode in command-line
set wildmenu

" Breaking
set tw=80
set wrap
set nolinebreak
set breakindent
set breakindentopt=min:40
set cpoptions=aABcefFqsZ
set formatoptions=tcrqnj

set list "show non-printable characters
if has('multi_byte') && &encoding ==# 'utf-8'
    let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
    let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

" F1 to qucikly run program
map <F1> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cc'
        exec "!g++ --std=c++11 % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python3 %"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'go'
        exec "!time go run %"
    endif
endfunc

" Google python style
setlocal indentexpr=GetGooglePythonIndent(v:lnum)

let s:maxoff = 50 " maximum number of lines to look backwards.

function GetGooglePythonIndent(lnum)

  " Indent inside parens.
  " Align with the open paren unless it is at the end of the line.
  " E.g.
  "   open_paren_not_at_EOL(100,
  "                         (200,
  "                          300),
  "                         400)
  "   open_paren_at_EOL(
  "       100, 200, 300, 400)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        \ . " =~ '\\(Comment\\|String\\)$'")
  if par_line > 0
    call cursor(par_line, 1)
    if par_col != col("$") - 1
      return par_col
    endif
  endif

  " Delegate the rest to the original function.
  return GetPythonIndent(a:lnum)

endfunction

let pyindent_nested_paren="&sw*2"
let pyindent_open_paren="&sw*2"

augroup vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" vim-plug & plugins
" call plug#begin('~/.vim/plugged')
" call plug#begin('~/.config/nvim/plugged')
call plug#begin()
Plug 'tpope/vim-sensible'
" On-demand loading
Plug 'preservim/nerdtree', {'on':'NERDTreeToggle'}
Plug 'tpope/vim-fugitive' "git plugin
Plug 'vim-airline/vim-airline'
Plug 'majutsushi/tagbar'
Plug 'ervandew/supertab'
Plug 'valloric/youcompleteme'
Plug 'dense-analysis/ale'
Plug 'easymotion/vim-easymotion'
Plug 'vim-scripts/a.vim' "quick cmds to switch src and header files, example :A
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'iamcco/markdown-preview.nvim' 
Plug 'jiangmiao/auto-pairs'
Plug 'jceb/vim-orgmode'
Plug 'tomasr/molokai'
Plug 'mileszs/ack.vim'
Plug 'yegappan/grep'
Plug 'junegunn/fzf'
Plug 'Yggdroot/indentLine'
Plug 'preservim/nerdcommenter'
Plug 'davidhalter/jedi-vim'
Plug 'google/yapf'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'google/vim-searchindex'
Plug 'fisadev/vim-isort'
Plug 'lervag/vimtex'
call plug#end()
call glaive#Install()

" nerdtree (file system explorer)
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F2> :NERDTreeToggle<CR>
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1
let NERDTreeShowHidden=1
let NERDTreeWinSize=30
let g:nerdtree_tabs_open_on_console_startup=1
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
let NERDTreeShowBookmarks=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeMinimalUI=1

" vim-airline (status/tabline for vim)
""""""""""""""""""""""""""""""""""""""""""""""""""
" display all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1

" tagbar (display ctags-generated tags of current file)
""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <F8> :TagbarToggle<CR>

" supertab (use <Tab> for all insert completion needs) 
" YCM (make YCM compatible with UltiSnips using supertab)
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
nmap gi :YcmCompleter GoToInclude<CR>
nmap gm :YcmCompleter GoToImprecise<CR>
nmap gr :YcmCompleter GoToReferences<CR>
nmap fi :YcmCompleter FixIt<CR>

" Ale (syntax checker and linter)
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_fixers = {
\    'python' : ['prettier'],
\    'c++' : ['prettier'],
\    }

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['flake8'],
\   'go': ['go', 'golint', 'errcheck']
\}
" disable highlighting
let g:ale_set_highlights=0
" only run linting when saving the file
let g:ale_lint_on_text_changed='never'
let g:ale_lint_on_enter=0

" easymotion
""""""""""""""""""""""""""""""""""""""""""""""""""
map <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
nmap <Leader>s <Plug>(easymotion-overwin-f2)
" move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
" move to word
map <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" ctrlp (full path fuzzy file, buffer, mru, tag, ... finder for vim)
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0
" quickly find and open a file in current working directory
let g:ctrlp_map = '<C-p>' " <c-f> and <c-b> to cycle between modes
let g:ctrlp_cmd = 'CtrlP'
" map <leader>j :CtrlP<cr>
" quickly find and open a buffer
" map <leader>b :CtrlPBuffer<cr>

let g:ctrlp_max_height = 20
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

" color theme
""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai

" set background=dark

" vim-markdown
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:markdown_fenced_languages = ['html', 'c++=cpp', 'viml=vim', 'python', 'bash=sh', 'csharp=cs']
" let g:markdown_syntax_conceal = 0
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_math = 1

" markdown-preview
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }
let g:mkdp_page_title = '「${name}」'
let g:mkdp_filetypes = ['markdown']

nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle

" ultisnips
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"

" nerdcommenter
""""""""""""""""""""""""""""""""""""""""""""""""""
" let mapleader=','
let g:NERDCreateDefaultMappings=1
let g:NERDSpaceDelims=1
let g:NERDCompactSexyComs=1
let g:NERDDefaultAlign='left'
let g:NERDCustomDelimiters={'c': {'left':'/**', 'right':'*/'}}
let g:NERDCommentEmptyLines=1
let g:NERDTrimTrailingWhitespace=1
let g:NERDToggleCheckAllLines=1

" yapf (python formatter for google open source projects)
""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>
" isort (sort the python import)
" autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>

" google vim-codefmt (code formatting with maktaba and glaive)
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>fc :FormatCode<CR>
nnoremap <leader>fl :FormatLines<CR>

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " autocmd FileType python AutoFormatBuffer autopep8
  autocmd FileType rust AutoFormatBuffer rustfmt
  autocmd FileType vue AutoFormatBuffer prettier
augroup END

" vim-isort (sort python imports)
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_isort_map = '<C-i>'
" augroup IsortMappings
    " autocmd!
    " autocmd FileType python nnoremap <buffer> <Leader>si :Isort<CR>
    " autocmd FileType python vnoremap <buffer> <Leader>si :Isort<CR>
" augroup END
" call isort#Isort(1, line('$'), function('codefmt#FormatBuffer'))

" vimtex (latex config)
""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_imaps_enabled=0 "disable insert mode mappings (e.g. if use Ultisnips)
" let g:vimtex_syntax_enabled=0 "disable syntax conceal
" let g:vimtex_syntax_conceal_disable=1 "disable syntax conceal
augroup conceal
  autocmd!
  autocmd InsertEnter *.tex set conceallevel=0
  autocmd InsertLeave *.tex set conceallevel=2
  autocmd InsertEnter *.md set conceallevel=0
  autocmd InsertLeave *.md set conceallevel=2
augroup END
