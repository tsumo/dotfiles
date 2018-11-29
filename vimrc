set nocompatible

set history=10000   " Lines of command history to remember

set tabstop=4       " Show tabs as n spaces
set softtabstop=4   " Number of spaces to insert with TAB or delete with BS
set expandtab       " Insert n spaces instead tab
set shiftwidth=4    " Indent size for normal mode commands

set autoindent      " Copy indent from current line to new line
set smartindent

set clipboard+=unnamedplus

set termguicolors   " For colorschemes

filetype on
filetype plugin on
filetype indent on  " Load file-specific indent files

" Makes plugins more snappy
set updatetime=750

" Dirs to store .swp files and backups
" Double slash protects from filename conflicts
set directory=~/.vim/tmp//,/var/tmp//,/tmp//
set backupdir=~/.vim/tmp//,/var/tmp//,/tmp//

" Persistent undo
let s:undoDir = "/tmp/.undodir_" . $USER
if !isdirectory(s:undoDir)
    call mkdir(s:undoDir, "", 0700)
endif
let &undodir=s:undoDir
set undofile

"====
" UI
"====
syntax on           " Syntax highlighting
set ruler           " Show cursor position in bottom right corner
set wrap            " Wrap lines
set scrolloff=3     " Number of context lines visible above or below cursor
set sidescrolloff=3 " Number of context rows visible to the left of right of the cursor
set showcmd         " Show command in bottom bar
set showtabline=2   " Always show tab bar at the top
set laststatus=2    " Always show status line at the bottom
set showmatch       " Highlight matching parenthesis
set wildmenu        " Visual autocomplete for commands
set wildmode=longest:full,full
set lazyredraw      " Redraw only when we need to
set shortmess+=I    " Don't display intro message
set mouse=a         " Enables mouse interaction in all modes
set breakindent     " Preserve indentation for wrapped lines
" Fix slow O inserts
set timeout timeoutlen=1000 ttimeoutlen=100

" Absolute line numbers for insert mode and unfocused windows
" Relative line numbers for normal mode
" Do not enable line numbers inside NERDTree
set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * if !exists("b:NERDTree") | set relativenumber | endif
    autocmd BufLeave,FocusLost,InsertEnter   * if !exists("b:NERDTree") | set norelativenumber | endif
augroup END

" Draw crosshair on the cursor position in the current window
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline cursorcolumn
  au WinLeave * setlocal nocursorline nocursorcolumn
augroup END

" Remember last cursor position when opening a file
" Don't do it for commit messages
if has("autocmd")
    au BufReadPost * if &ft != 'gitcommit' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"========
" SPLITS
"========
"Open new split panels to right and bottom
set splitbelow
set splitright

" Navigating between splits with Ctrl+hjkl
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Resize splits with Shift+arrows
" Up increases current buffer height
" Down decreases current buffer height
nnoremap <silent> <S-Up> :resize +3<CR>
nnoremap <silent> <S-Down> :resize -3<CR>
" Right increases current buffer width
" Left decreases current buffer width
nnoremap <silent> <S-Right> :vertical resize +5<CR>
nnoremap <silent> <S-Left> :vertical resize -5<CR>

"===========
" SHORTCUTS
"===========
" Space inserts default leader
" Useful because if shows leader symbol in command line
map <Space> <Leader>

" Disable Ex mode
nmap Q <silent>
" Disable command history window
nmap q: <silent>

" Faster scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" fzf - open files tracked by git
nnoremap <C-p> :GFiles<CR>
" Open files
nnoremap <M-p> :Files<CR>

" Grepper - search word under cursor
nnoremap <leader>* :Grepper -tool ag -cword -noprompt<cr>
" Start search with ag
nnoremap <leader>/ :Grepper -tool ag<cr>

" pdv document
autocmd FileType php nnoremap <leader>d :call pdv#DocumentCurrentLine()<CR>

" Toggle gitgutter
nnoremap <leader>g :GitGutterToggle<CR>

" Toggle auto-indenting for code paste in normal mode
nnoremap <F2> :set invpaste paste?<CR>
" and in insert mode
set pastetoggle=<F3>

" Stop highlighting searches
nmap <leader>h :nohl<CR>

" Open same file in new tab
nmap <leader>t :tab split<CR>
" Open same file in new tab in last position
nmap <leader>T :tab split<CR>:tabm<CR>

" Use plus and minus to increment/decrement numbers
noremap + <C-a>
noremap - <C-x>

" Preserve visual selection when indenting with < and >
vnoremap < <gv
vnoremap > >gv

" Moving line up and down with Ctrl+up/down, autoindent both swapped lines
nmap <C-Up> ddkP==j==k==
nmap <C-Down> ddp==k==j==

" Up and Down navigate inside long lines
" Left and Right scroll window, keeping cursor
" in the same line on screen
" No arrow keys in insert and visual
noremap <Up> gk
noremap <Down> gj
noremap <Left> 3<C-y>3gk
noremap <Right> 3<C-e>3gj
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
vnoremap <Up> <NOP>
vnoremap <Down> <NOP>
vnoremap <Left> <NOP>
vnoremap <Right> <NOP>

" Repeat last command in the last tmux pane.
nnoremap <Leader>r :call <SID>TmuxRepeat()<CR>

function! s:TmuxRepeat()
    silent! write
    silent! exec "!tmux select-pane -l && tmux send up enter && tmux select-pane -l"
    redraw!
endfunction

" Mapping cyrillic layout for normal mode
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

"========
" SEARCH
"========
set incsearch       " Start searching as you type
set hlsearch        " Highlight search patterns
" Automatically ignore case for lowercase searches,
" case-sensitive for searches with uppercase letters
set ignorecase
set smartcase
" Stops ignorecase from affecting completion
" Makes completion case-sensitive again
set infercase

"===================
" SPELLING MISTAKES
"===================
abbr feild field
abbr docuemnt document
abbr arrya array
abbr flase false

"============
" STATUSLINE
"============
set statusline=
set statusline+=\ %<%f\ (%{&ft})        " filename, filetype
set statusline+=\ %-4(%m%)              " modified flag
set statusline+=%=%-19(%3l,%02c%03V%)%P " ruler

"======================
" INVISIBLE CHARACTERS
"======================
" Toggle invisible characters
nmap <silent> <leader>l :set list!<CR>
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
" Invisible character colors
highlight NonText cterm=none ctermfg=0 guifg=#cb4b16
" highlight CursorLineNr cterm=none ctermfg=0 guifg=#b58900
" highlight SpecialKey cterm=none ctermfg=0 guifg=#b58900 ctermbg=8 guibg=#b58900

" Highlight trailing whitespaces, but not while
" typing in insert mode
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

"=========
" PLUGINS
"=========
" VimPlug
call plug#begin('~/.local/share/nvim/plugged')
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'mhinz/vim-grepper'
Plug 'pangloss/vim-javascript'
Plug 'jiangmiao/auto-pairs'
Plug 'kovisoft/slimv', { 'for': 'lisp' }
Plug 'docunext/closetag.vim'
Plug 'vimwiki/vimwiki'
Plug 'vim-vdebug/vdebug', { 'on': 'VdebugStart' }
Plug 'mattn/emmet-vim'
Plug 'chrisbra/Colorizer'
" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Clojure
Plug 'tpope/vim-fireplace'
" PHP
Plug 'tobyS/vmustache'
Plug 'tobyS/pdv', { 'for': 'php' }
" Solidity
Plug 'tomlion/vim-solidity'
" Colorschemes
Plug 'lifepillar/vim-solarized8'
Plug 'ajh17/Spacegray.vim'
Plug 'morhetz/gruvbox'
call plug#end()

" Disable ALE for now
autocmd VimEnter * if exists('g:loaded_ale') | ALEDisable | endif
" Toggle ALE
nmap <leader>al :ALEToggle<CR>

" Grepper - search in hidden files
runtime plugin/grepper.vim
let g:grepper.ag.grepprg .= ' --hidden --ignore .git'

" Enable deoplete
let g:deoplete#enable_at_startup = 1

" Open REPL in vertical right split
let g:slimv_repl_split=4
" Rainbow parens
let g:lisp_rainbow=1

" Skips autopairs init for lisp files
" since slimv already contains paredit
au FileType lisp let b:autopairs_loaded=1
" Disable toggle shortcut
let g:AutoPairsShortcutToggle = ''

" Custom comment style
autocmd FileType php setlocal commentstring=//\ %s

" Open NERDTree
nmap <leader>nt :NERDTreeToggle<CR>
" Close vim when NERDTree is the only window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Open file and folders with l, ranger-style
let NERDTreeMapActivateNode='l'
" Show hidden files (toggled with I)
let NERDTreeShowHidden=1

" Open Tagbar
nmap <leader>tb :TagbarToggle<CR>

" Smaller fzf window
let g:fzf_layout = { 'down': '~20%' }
" Hide fzf buffer statusline
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" pdv templates
let g:pdv_template_dir = $HOME . "/.local/share/nvim/plugged/pdv/templates"

" Stop gitgutter from injecting shortcuts
let g:gitgutter_map_keys = 0
" gitgutter colors
highlight link GitGutterAdd String
highlight link GitGutterChange Type
highlight link GitGutterDelete Function
highlight link GitGutterChangeDelete Function

" Css colors
let g:colorizer_auto_filetype='css,html'

" Use markdown in vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
" Turn off creation of temporary wikis for all .md files
let g:vimwiki_global_ext = 0

" javascript plugin keeps adding $ to the keyword list in php files
augroup phpjsfix
    autocmd!
    autocmd FileType javascript setlocal iskeyword+=$
    autocmd FileType php setlocal iskeyword-=$
augroup END

"==================================================================
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
" by garybernhardt
"==================================================================
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-n>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-p>

"=============
" Colorscheme
"=============
try
    set background=dark
    let g:gruvbox_bold=1
    let g:gruvbox_italic=1
    let g:gruvbox_underline=1
    let g:gruvbox_undercurl=1
    let g:gruvbox_italicize_comments=1
    let g:gruvbox_invert_selection=0
    colorscheme gruvbox
catch
    colorscheme desert
endtry

"=====================
" Local configuration
"=====================
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

