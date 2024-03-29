" For neovim, create init.vim file, add the following contents 
" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc

set nocompatible
" execute pathogen#infect()

" ==================== Basic Config ====================
filetype plugin indent on
syntax on
set number
set encoding=utf-8

" ==================== Indent settings ====================
set autoindent
set cinoptions=l1,p0,)50,*50,t0
set expandtab "use spaces instead of tabs
set smarttab
set softtabstop=4 "Tab key indents by 4 spaces
set shiftwidth=4 ">> indents by 4 spaces
set shiftround ">> indents to next multiple of 'shiftwidth'

" backup/swap/info/undo settings
" set nobackup
" set nowritebackup
" set undofile
" set swapfile
" set backupdir=$HOME/.vim/files/backup/
" set directory=$HOME/.vim/files/swap//
" set undodir=$HOME/.vim/files/undo/
" set viewdir=$HOME/.vim/files/view

" if !has('nvim')
"   " set viminfo=%,<800,'10,/50,:100,h,f0,n~/.vim/files/info/viminfo
"   set viminfo='1000,f1,\"500,:1000,%,n~/.viminfo
" else
"   " Do nothing here to use the neovim default
"   " or do soemething like:
"   " set viminfo+=n~/.shada
" endif

" ==================== Navigation ====================
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

" ==================== Miscellaneous ====================
set autoread
set backspace=indent,eol,start
set clipboard=unnamedplus "unnamed
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
set updatetime=300

" ==================== Display ====================
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

" ==================== Breaking ====================
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

" ==================== Compile Function ====================
map <F1> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -o %< && !time ./%<"
    elseif &filetype == 'cc'
        exec "!g++ -std=c++11 % -Wall -o %< && !time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ -std=c++11 % -Wall -o %< && !time ./%<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python3 %"
    elseif &filetype == 'java'
        exec "!javac % && !time java %<"
    elseif &filetype == 'go'
        exec "!time go run %"
    endif
endfunc

" ==================== Google Python Style ====================
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

" ==================== Autocmd ====================
augroup vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" ==================== Plugins ====================
call plug#begin()
" ==================== Editing & Navigation ====================
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/a.vim' "quick cmds to switch src and header files, example :A
Plug 'ervandew/supertab'
Plug 'easymotion/vim-easymotion'
Plug 'dhruvasagar/vim-table-mode'
Plug 'mbbill/undotree'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'junegunn/goyo.vim'
" ==================== Snippets ====================
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" ==================== Coding & Debug ====================
Plug 'preservim/nerdtree', {'on':'NERDTreeToggle'}
Plug 'preservim/nerdcommenter'
Plug 'Yggdroot/indentLine'
" Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags' " manage tags
Plug 'skywind3000/gutentags_plus'
" Plug 'github/copilot.vim'
Plug 'vim-test/vim-test'
" Plug 'puremourning/vimspector' " A multi-language debugging system
" ==================== Search (ctrlp/ack/fzf/rg/ag) ====================
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
" ==================== UI & Colorscheme ====================
Plug 'vim-airline/vim-airline'
Plug 'mhinz/vim-startify'
Plug 'tomasr/molokai'
Plug 'luochen1990/rainbow'
Plug 'theniceboy/nvim-deus'
" ==================== Git ====================
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" ==================== Syntax & auto-completion (ycm/deoplete/coc) ====================
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'sheerun/vim-polyglot' " syntax and indentation support
Plug 'neomake/neomake' " Asynchronous linting and make framework
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Conquer of Completion
Plug 'wellle/tmux-complete.vim'
" Plug 'valloric/youcompleteme'
" Plug 'dense-analysis/ale' " Asynchronous Lint Engine, LSP client
" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif
" Plug 'deoplete-plugins/deoplete-jedi'
" ==================== Code Format ====================
" Plug 'google/vim-maktaba'
" Plug 'google/vim-codefmt'
" Plug 'google/vim-glaive'
Plug 'sbdchd/neoformat'
" ==================== C/C++ ====================
" ==================== Python ====================
" Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'davidhalter/jedi-vim'
Plug 'fisadev/vim-isort'
Plug 'KangOl/vim-pudb'
" ==================== Go ====================
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'  }
" ==================== Swift ====================
Plug 'keith/swift.vim'
" ==================== Tex ====================
Plug 'lervag/vimtex'
" ==================== Markdown & Org-mode ====================
Plug 'preservim/vim-markdown'
Plug 'mzlogin/vim-markdown-toc' " :GenTocXXX to generate table of contents
Plug 'dhruvasagar/vim-table-mode'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'jceb/vim-orgmode'
call plug#end()
" call glaive#Install()

" ==================== Plugins Config ====================
" ========================================================
" ==================== vim-easy-align ====================
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ==================== SuperTab ====================
let g:SuperTabDefaultCompletionType = '<C-n>'

" ==================== EasyMotion ====================
" <Leader>f{char} to move to {char}
map <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
nmap <Leader>s <Plug>(easymotion-overwin-f2)
" Move to word
map <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
" case-insensitive feature
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1 " US layout
" line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" ==================== vim-table-mode ====================
noremap <Leader>tm :TableModeToggle<CR>
"let g:table_mode_disable_mappings = 1
let g:table_mode_cell_text_object_i_map = 'k<Bar>'

" ==================== undotree ====================
nnoremap <F4> :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2

" ==================== goyo ====================
map <Leader>gy :Goyo<CR>

" ==================== ultisnips ====================
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"

" ==================== nerdtree ====================
nnoremap <F2> :NERDTreeToggle<CR>
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1
let NERDTreeShowHidden=0
let NERDTreeWinSize=30
let g:nerdtree_tabs_open_on_console_startup=1
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
let NERDTreeShowBookmarks=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeMinimalUI=1

" ==================== nerdcommenter ====================
let g:NERDCreateDefaultMappings=1
let g:NERDCreateDefaultMappings=1
let g:NERDSpaceDelims=1
let g:NERDCompactSexyComs=1
let g:NERDDefaultAlign='left'
let g:NERDCustomDelimiters={'c': {'left':'/**', 'right':'*/'}}
let g:NERDCommentEmptyLines=1
let g:NERDTrimTrailingWhitespace=1
let g:NERDToggleCheckAllLines=1

" ==================== gutentags ====================
" C-] jump to definition, C-o jump back
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_modules = ['ctags', 'gtags_cscope']
let g:gutentags_cache_dir = expand('~/.cache/tags')
let g:gutentags_plus_switch = 1
" ctags config
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extras=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxl']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" if universal ctags is used, add e-ctags
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags'] 
" let g:gutentags_auto_add_gtags_cscope = 0
" let g:gutentags_define_advanced_commands = 1
" let g:gutentags_trace = 1

" ==================== copilot ====================
" let g:copilot_enabled = 0
" nnoremap <silent> <leader>go :Copilot<CR>
" nnoremap <silent> <leader>ge :Copilot enable<CR>
" nnoremap <silent> <leader>gd :Copilot disable<CR>
" inoremap <c-p> <Plug>(copilot-suggest)
" inoremap <c-n> <Plug>(copilot-next)
" inoremap <c-l> <Plug>(copilot-previous)

" ==================== vim-test ====================
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
" nmap <silent> <leader>a :TestSuite<CR>
" nmap <silent> <leader>l :TestLast<CR>
" nmap <silent> <leader>v :TestVisit<CR>

" ==================== vimspector ====================
" let g:vimspector_enable_mappings = 'HUMAN'
" let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]
" " debug inspect (di)
" nmap <Leader>di <Plug>VimspectorBalloonEval
" xmap <Leader>di <Plug>VimspectorBalloonEval

" ==================== LeaderF ====================
" let g:Lf_WorkingDirectoryMode = 'AF'
" let g:Lf_RootMarkers = ['.git', '.svn', '.hg', '.project', '.root']
" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0, 'Colorscheme':1}
let g:Lf_ShortcutF = "<c-p>"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
noremap <leader>ff :LeaderfFunction<cr>

noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" search visually selected text literally
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR>

" should use `Leaderf gtags --update` first
" let g:Lf_GtagsAutoGenerate = 0
" let g:Lf_Gtagslabel = 'native-pygments'
" noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
" noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
" noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
" noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
" noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

" ==================== vim-airline ====================
" display all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1

" ==================== Color Theme ====================
" molokai
let g:rehash256 = 1
colorscheme molokai

" Deus
" set termguicolors " enable true colors support
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" silent! color deus
"
" hi NonText ctermfg=gray guifg=grey10
" " hi SpecialKey ctermfg=blue guifg=grey70

" ==================== vim-rainbow ====================
let g:rainbow_active = 1

" ==================== Treesitter ====================
if has('nvim')
lua <<EOF
require "nvim-treesitter.configs".setup {
  ensure_installed = {"bash", "c", "go", "java", "lua", "swift"},
  -- ensure_installed = "all",
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = {"BufWrite", "CursorHold"},
    },
  }
}
EOF
" toggle the tree using command :TSPlaygroundToggle
map <F9> :TSPlaygroundToggle<CR>
" show treesitter and syntax highlight groups under cursor
map <F10> :TSHighlightCapturesUnderCursor<CR>
else
  " Do nothing
endif

" ==================== Neomake ====================
" Asynchronous linting and make framework
call neomake#configure#automake('nw', 1000)
" let g:neomake_open_list = 2

" ==================== CoC ====================
" Conquer of Completion
let g:coc_global_extensions = [
	\ 'coc-marketplace',
	\ 'coc-diagnostic',
	\ 'coc-eslint',
	\ 'coc-java',
	\ 'coc-json',
	\ 'coc-lists',
	\ 'coc-snippets',
	\ 'coc-syntax',
	\ 'coc-translator',
	\ 'coc-vimlsp']
" coc-prettier, coc-pyright, coc-stylelint

" nnoremap <c-c> :CocCommand<CR>

" coc-diagnostic
nnoremap <silent><nowait> <Leader>d :CocList diagnostics<cr>
" nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
" nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> g] <Plug>(coc-diagnostic-prev)

" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" " nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
" nmap <leader>rn <Plug>(coc-rename)
" coc-translator (popup)
nmap <Leader>tr <Plug>(coc-translator-p)
vmap <Leader>tr <Plug>(coc-translator-pv)

" ==================== tmux-complete ====================
" trigger with <C-X><C-U>
let g:tmuxcomplete#trigger = 'completefunc'

" ==================== python-mode ====================
" let g:pymode_rope = 1
" let g:pymode_lint = 1
" let g:pymode_lint_checkers = [‘pyflakes’, ‘pep8’]
" let g:pymode_lint_write = 1
" let g:pymode_virtualenv = 1
" let g:pymode_breakpoint = 1
" let g:pymode_syntax = 1
" let g:pymode_syntax_all = 1
" let g:pymode_syntax_indent_errors = g:pymode_syntax_all
" let g:pymode_syntax_space_errors = g:pymode_syntax_all
" let g:pymode_rope_goto_definition_bind = "<C-g>"

" ==================== jedi-vim ====================
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
" let g:jedi#goto_stubs_command = "<leader>s"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
" let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
" if completion is too slow
" let g:pymode_rope = 0
" use deoplete-jedi (asynchronously), disable jedi-vim's completion
" let g:jedi#completions_enabled = 0

" ==================== vim-isort ====================
" let g:vim_isort_map = '<C-i>'
augroup IsortMappings
    autocmd!
    autocmd BufWritePre *.py :Isort
augroup END

" ==================== vim-pudb ====================
nnoremap <F8> :TogglePudbBreakPoint<CR>
inoremap <F8> <ESC>:TogglePudbBreakPoint<CR>a

" ==================== vim-go ====================
let g:go_echo_go_info = 0
let g:go_doc_popup_window = 1
let g:go_def_mapping_enabled = 0
let g:go_template_autocreate = 0
let g:go_textobj_enabled = 0
let g:go_auto_type_info = 1
let g:go_def_mapping_enabled = 0
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 0
let g:go_highlight_variable_declarations = 0
let g:go_doc_keywordprg_enabled = 0

" ==================== vimtex ====================
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

" ==================== vim-markdown ====================
let g:markdown_fenced_languages = ['html', 'c++=cpp', 'viml=vim', 'python', 'bash=sh', 'csharp=cs']
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_math = 1

" ==================== vim-table-mode ====================
noremap <Leader>tm :TableModeToggle<CR>
"let g:table_mode_disable_mappings = 1
let g:table_mode_cell_text_object_i_map = 'k<Bar>' " k|

" ==================== markdown-preview.nvim ====================
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
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }

let g:mkdp_filetypes = ['markdown']
let g:mkdp_theme = 'dark'
nmap <C-s> <Plug>MarkdownPreviewToggle

" ==================== neoformat ====================
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

" ==================== Google vim-codefmt ====================
" nnoremap <leader>fc :FormatCode<CR>
" nnoremap <leader>fl :FormatLines<CR>
"
" augroup autoformat_settings
"   autocmd FileType bzl AutoFormatBuffer buildifier
"   autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
"   autocmd FileType dart AutoFormatBuffer dartfmt
"   autocmd FileType go AutoFormatBuffer gofmt
"   autocmd FileType gn AutoFormatBuffer gn
"   autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
"   autocmd FileType java AutoFormatBuffer google-java-format
"   autocmd FileType python AutoFormatBuffer yapf
"   " autocmd FileType python AutoFormatBuffer autopep8
"   autocmd FileType rust AutoFormatBuffer rustfmt
"   autocmd FileType vue AutoFormatBuffer prettier
" augroup END

" ==================== tagbar ====================
" nmap <F6> :TagbarToggle<CR>

" ==================== ctrlp ====================
" full path fuzzy file, buffer, mru, tag, ... finder
" let g:ctrlp_working_path_mode = 0
" " quickly find and open a file in current working directory
" let g:ctrlp_map = '<C-p>' " <c-f> and <c-b> to cycle between modes
" let g:ctrlp_cmd = 'CtrlP'
" " map <leader>j :CtrlP<cr>
" " quickly find and open a buffer
" " map <leader>b :CtrlPBuffer<cr>
" let g:ctrlp_max_height = 20
" set wildignore+=*/tmp/*,*.so,*.swp,*.zip
" let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

" ==================== YCM ====================
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" let g:ycm_autoclose_preview_window_after_completion=1
" map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" nmap gi :YcmCompleter GoToInclude<CR>
" nmap gm :YcmCompleter GoToImprecise<CR>
" nmap gr :YcmCompleter GoToReferences<CR>
" nmap fi :YcmCompleter FixIt<CR>

" ==================== deoplete ====================
""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:deoplete#enable_at_startup = 1

" ==================== Ale ====================
" syntax checker and linter
" let g:ale_fixers = {
" \    'python' : ['prettier'],
" \    'c++' : ['prettier'],
" \    }
"
" let g:ale_linters = {
" \   'javascript': ['eslint'],
" \   'python': ['flake8'],
" \   'go': ['go', 'golint', 'errcheck']
" \}
" " disable highlighting
" let g:ale_set_highlights=0
" " only run linting when saving the file
" let g:ale_lint_on_text_changed='never'
" let g:ale_lint_on_enter=0
