syntax on                   " syntax highlighting
filetype plugin on          " enable filetype detection
filetype plugin indent on   "allow auto-indenting depending on file type

set nocompatible        " disable compatibility to old-time vi
set nobackup            " don't make backup files
set autoread            " automatically read files when opened
set matchtime=1         " match the whole line
set report=0            " don't show error messages
set fencs=utf-8,gbk     " set the default encoding
set termencoding=utf-8  " set the terminal encoding
set encoding=utf-8      " set the file encoding

set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
set ttyfast                 " speed up scrolling in Vim
set ignorecase              " ignore case

" display
set number          " show absolute line numbers
set showcmd         " show command in status line
set ruler           " show line numbers in the bottom
set cursorline      " highlight current line
set showmatch       " highlight matching brackets
set hlsearch        " highlight search
set incsearch       " incremental search

if has("termguicolors") && has("nvim") " set true colors on NeoVim
    set termguicolors
endif

set autoindent      " indent a new line the same amount as the line just typed
set expandtab       " converts tabs to white space
set tabstop=4       " number of columns occupied by a tab 
set softtabstop=4   " see multiple spaces as tabstops so <BS> does the right thing
set shiftwidth=4    " width for autoindents

set foldmethod=indent   " fold by indentation
set foldlevelstart=99   " start folding at 99
set laststatus=2        " show status bar

" install vim-plug
" unix
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" windows
" iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | ni $HOME/vimfiles/autoload/plug.vim -Force

" vim-plug path
call plug#begin('~/.vim/plugged')

" themes
Plug 'crusoexia/vim-monokai'
Plug 'ryanoasis/vim-devicons'
Plug 'luochen1990/rainbow'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" components
Plug 'nanotee/zoxide.vim'
Plug 'preservim/tagbar'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'sbdchd/neoformat'
Plug 'Yggdroot/indentLine'

" completions
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'github/copilot.vim'
Plug 'rhysd/github-complete.vim'
Plug 'JuliaEditorSupport/julia-vim'

" note-taking
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

call plug#end()

colorscheme monokai

" coc.nvim
let g:coc_global_extensions = [
    \ 'coc-lists',
    \ 'coc-pairs',
    \ 'coc-git',
    \ 'coc-emmet',
    \ 'coc-css',
    \ 'coc-eslint',
    \ 'coc-jedi',
    \ 'coc-gitignore',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-prettier',
    \ 'coc-python',
    \ 'coc-yaml']

" airline
" let g:airline_theme = 'silver'
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#keymap#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_idx_format = {
       \ '0': '0 ',
       \ '1': '1 ',
       \ '2': '2 ',
       \ '3': '3 ',
       \ '4': '4 ',
       \ '5': '5 ',
       \ '6': '6 ',
       \ '7': '7 ',
       \ '8': '8 ',
       \ '9': '9 '
       \}

let g:airline_section_warning = ''

let g:airline_section_c = ''
" let g:airline_section_x = ''
let g:airline_section_z = airline#section#create_right(['%l', '%c'])

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>, <Plug>AirlineSelectPrevTab
nmap <leader>. <Plug>AirlineSelectNextTab
nmap <leader>q :bp<cr>:bd #<cr>

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

" unicode symbols
"   let g:airline_left_sep = '»'
"   let g:airline_right_sep = '«'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = '⁇'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

" nerdtree
map <C-[> :NERDTreeToggle <CR>

let g:NERDTreeQuitOnOpen = 1

let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeMinimalUI = 1

let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

let g:NERDTreeHidden=0
let g:NERDTreeShowBookmarks=1
let g:NERDTreeShowHidden = 0
let g:NERDTreeShowLineNumbers=0
let g:NERDTreeWinPos='left'
let g:NERDTreeWinSize = 25

let g:NERDTreeGitStatusShowClean = 1
" let g:NERDTreeGitStatusConcealBrackets = 1
" let g:NERDTreeGitStatusIndicatorMapCustom = {
"                 \ 'Modified'  :'✹',
"                 \ 'Staged'    :'✚',
"                 \ 'Untracked' :'✭',
"                 \ 'Renamed'   :'➜',
"                 \ 'Unmerged'  :'═',
"                 \ 'Deleted'   :'✖',
"                 \ 'Dirty'     :'✗',
"                 \ 'Ignored'   :'☒',
"                 \ 'Clean'     :'✔︎',
"                 \ 'Unknown'   :'?',
"                 \ }


autocmd vimenter * if !argc()|NERDTree|
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif


" tagbar
map <C-]> :TagbarToggle <CR>

" let g:tagbar_left = 1
let g:tagbar_width=25
let g:tagbar_type_markdown = {
        \ 'ctagstype' : 'markdown',
        \ 'kinds' : [
                \ 'h:headings',
        \ ],
    \ 'sort' : 0
\ }

" nerdcommenter
let g:NERDCreateDefaultMappings = 1     " Create default mappings
let g:NERDDefaultAlign = 'left'         " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDSpaceDelims = 1               " Add spaces after comment delimiters by default
let g:NERDTrimTrailingWhitespace = 1    " Enable trimming of trailing whitespace when uncommenting
let g:NERDToggleCheckAllLines = 1       " Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDCommentEmptyLines = 1
let g:NERDCompactSexyComs = 1

" rainbow
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
\   'guifgs': ['darkorange3', 'seagreen3', 'royalblue3', 'firebrick'],
\   'ctermfgs': ['lightyellow', 'lightcyan','lightblue', 'lightmagenta'],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'tex': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\       },
\       'lisp': {
\           'guifgs': ['darkorange3', 'seagreen3', 'royalblue3', 'firebrick'],
\       },
\       'vim': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\       },
\       'html': {
\           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\       },
\       'css': 0,
\   }
\}

" indentLine
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indentLine_char_list = '┆'
" let g:indentLine_defaultGroup = 'SpecialKey'

" markdown
let g:mkdp_auto_start = 0           " open the preview window after entering the markdown buffer
let g:mkdp_auto_close = 1           " close the preview window after leaving the markdown buffer
let g:mkdp_refresh_slow = 0         " refresh markdown when save the buffer or leave from insert mode, default 0 is auto refresh markdown as you edit or move the cursor
let g:mkdp_command_for_global = 0   " MarkdownPreview command can be use for all files, by default it can be use in markdown file
let g:mkdp_open_to_the_world = 0    " preview server available to others in your network
" by default, the server listens on localhost
let g:mkdp_open_ip = ''             " use custom IP to open preview page
let g:mkdp_browser = ''             " specify browser to open preview page
let g:mkdp_echo_preview_url = 0     " echo preview page url in command line when open preview page
let g:mkdp_browserfunc = ''         " a custom vim function name to open preview page

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

let g:mkdp_markdown_css = ''            " use a custom markdown style must be absolute path
let g:mkdp_highlight_css = ''           " use a custom highlight style must absolute path
let g:mkdp_port = ''                    " use a custom port to start server or random for empty
let g:mkdp_page_title = '「${name}」'   " preview page title
let g:mkdp_filetypes = ['markdown']     " recognized filetypes


" mappings
nmap <C-s> <Plug>MarkdownPreview
nmap <C-p> <Plug>MarkdownPreviewToggle
nmap <M-s> <Plug>MarkdownPreviewStop
