set nocompatible
execute pathogen#infect()

" Vundle & plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'preservim/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'majutsushi/tagbar'
Plugin 'ervandew/supertab'
Plugin 'valloric/youcompleteme'
" Plugin 'scrooloose/syntastic'
" Plugin 'edsono/vim-matchit'
Plugin 'easymotion/vim-easymotion'
Plugin 'vim-scripts/a.vim'
Plugin 'tpope/vim-surround'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-markdown'
Plugin 'jiangmiao/auto-pairs'
Plugin 'jceb/vim-orgmode'
Plugin 'tomasr/molokai'
Plugin 'mileszs/ack.vim'
Plugin 'yegappan/grep'
Plugin 'junegunn/fzf'
Plugin 'Yggdroot/indentLine' 
Plugin 'tpope/vim-speeddating'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'preservim/nerdcommenter'
Plugin 'davidhalter/jedi-vim'
Plugin 'google/yapf'
Plugin 'dense-analysis/ale'
Plugin 'Chiel92/vim-autoformat'
" Plugin 'google/vim-colorscheme-primary'
call vundle#end()

" YCM (make YCM compatible with UltiSnips using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" nerdtree
map <F2> :NERDTreeToggle<CR>
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1
let NERDTreeShowHidden=1
let NERDTreeWinSize=30
let g:nerdtree_tabs_open_on_console_startup=1
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
let NERDTreeShowBookmarks=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeMinimalUI=1

" color theme molokai
let g:molokai_original = 1
let g:rehash256 = 1

" google vim color scheme
" syntax enable
" set t_Co=256
" set background=dark
" colorscheme primary

" vim-markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
let g:markdown_syntax_conceal = 0
let g:markdown_minlines = 100

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"

" syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" nerdcommenter
" let mapleader=','
let g:NERDCreateDefaultMappings=1
let g:NERDSpaceDelims=1
let g:NERDCompactSexyComs=1
let g:NERDDefaultAlign='left'
let g:NERDCustomDelimiters={'c': {'left':'/**', 'right':'*/'}}
let g:NERDCommentEmptyLines=1
let g:NERDTrimTrailingWhitespace=1
let g:NERDToggleCheckAllLines=1

" yapf (google tool for auto format python)
autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>
" isort (sort the python import)
autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>

" Ale
let g:ale_fixers = {
            \    'python' : ['prettier'],
            \    'c++' : ['prettier'],
            \    }

" vim-autoformat
" noremap <F3> :Autoformat<CR>
" au BufWrite * :Autoformat
let g:autoformat_autoindent=0
let g:autoformat_retab=0
let g:autoformat_remove_trailing_spaces=0

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
set backupdir=$HOME/.vim/files/backup/
set directory=$HOME/.vim/files/swap//
set undodir=$HOME/.vim/files/undo/
set viewdir=$HOME/.vim/files/view
set viminfo='100,n$HOME/.vim/files/info/viminfo

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

" Breaking
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
        exec "!g++ % -o %<"
        exec "!time ./%<"
    else if &filetype == 'cpp'
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
