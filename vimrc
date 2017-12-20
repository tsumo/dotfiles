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

" Dirs to store .swp files and backups
" Double slash protects from filename conflicts
set directory=~/.vim/tmp//,/var/tmp//,/tmp//
set backupdir=~/.vim/tmp//,/var/tmp//,/tmp//

"====
" UI
"====
syntax on           " Syntax highlighting
set ruler           " Show cursor position in bottom right corner
set wrap            " Wrap lines
set scrolloff=3     " Number of context lines visible above or below cursor
set showcmd         " Show command in bottom bar
set showtabline=2   " Always show tab bar at the top
set laststatus=2    " Always show status line at the bottom
set showmatch       " Highlight matching parenthesis
set wildmenu        " Visual autocomplete for commands
set wildmode=longest:full,full
set lazyredraw      " Redraw only when we need to
set shortmess+=I    " Don't display intro message
set mouse=a         " Enables mouse interaction in all modes
" Fix slow O inserts
set timeout timeoutlen=1000 ttimeoutlen=100

" Absolute line numbers for insert mode and unfocused windows
" Relative line numbers for normal mode
set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
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
" Faster scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" fzf open file
nnoremap <C-p> :Files<CR>

" Toggle auto-indenting for code paste in normal mode
nnoremap <F2> :set invpaste paste?<CR>
" and in insert mode
set pastetoggle=<F2>

" Stop highlighting searches
nmap <leader>n :nohl<CR>

" Open same file in new tab
nmap <leader>t :tab split<CR>
" Open same file in new tab in last position
nmap <leader>T :tab split<CR>:tabm<CR>

" Moving lines up and down with Ctrl+up/down
nmap <C-Up> ddkP
nmap <C-Down> ddp

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

" mapping cyrillic layout for normal mode
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

"============
" STATUSLINE
"============
" Toggle current git branch in statusline
nmap <leader>g :call StatuslineGitToggle()<CR>

function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

let g:StatuslineGitIsOn = 0

function! StatuslineGitToggle()
    if g:StatuslineGitIsOn
        let g:StatuslineGitIsOn = 0
        echo "Statusline Git is off"
    else
        let g:StatuslineGitIsOn = 1
        echo "Statusline Git is on"
    endif
endfunction

function! StatuslineGit()
    if g:StatuslineGitIsOn
        let l:branchname = GitBranch()
        return strlen(l:branchname) > 0?'  '.l:branchname:''
    endif
    return ''
endfunction

set statusline=
set statusline+=%{StatuslineGit()}      " git branch
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
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'lifepillar/vim-solarized8'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper'
call plug#end()

" solarized8 colorscheme
set background=dark
" Don't show errors if colorscheme doesn't exist
try
    colorscheme solarized8
catch
    colorscheme desert
endtry

" Disable ALE for now
autocmd VimEnter * if exists('g:loaded_ale') | ALEDisable | endif

" Open REPL in vertical right split
let g:slimv_repl_split=4
" Rainbow parens
let g:lisp_rainbow=1

" Open NERDTree
nmap <leader>ne :NERDTreeToggle<CR>
" Close vim when NERDTree is the only window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Open file and folders with l, ranger-style
let NERDTreeMapActivateNode='l'

" Smaller fzf window
let g:fzf_layout = { 'down': '~20%' }
" Hide fzf buffer statusline
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

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
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

"=====================
" Local configuration
"=====================
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

