set history=1000    " Lines of command history to remember

syntax on           " Syntax highlighting

"========
" COLORS
"========
set tabstop=4       " Show tabs as n spaces
set softtabstop=4   " Number of spaces in tab when editing
set expandtab       " Insert n spaces instead tab
filetype plugin on
filetype indent on  " Load file-specific indent files
set autoindent
set smartindent
set shiftwidth=4    " Indent size

"====
" UI
"====
set number          " Show line numbers
set wrap            " Wrap lines
set scrolloff=3     " Number of context lines visible above and below cursor
set showcmd         " Show command in bottom bar
set showmatch       " Highlight matching parenthesis
set wildmenu        " Visual autocomplete for commands
set wildmode=longest:full,full
set lazyredraw      " Redraw only when we need to

"========
" SEARCH
" =======
set incsearch       " Start searching as you type
set hlsearch        " Highlight search patterns
" Automatically ignore case for lowercase searches,
" case-sensitive for searches with uppercase letters
set smartcase

" Navigating inside long lines
" map j gj
" map k gk

" Toggle auto-indenting for code paste in normal mode
nnoremap <F2> :set invpaste paste?<CR>
" and in insert mode
set pastetoggle=<F2>

" mapping cyrillic layout for normal mode
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" No arrow keys
noremap <up> <NOP>
inoremap <up> <NOP>
noremap <down> <NOP>
inoremap <down> <NOP>
noremap <left> <NOP>
inoremap <left> <NOP>
noremap <right> <NOP>
inoremap <right> <NOP>

" Remember last cursor position when opening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Moving lines up and down with Ctrl+[jk]
nmap <C-k> ddkP
nmap <C-j> ddp

"======================
" INVISIBLE CHARACTERS
"======================
" Shortcut '\l' to rapidly toggle 'set list'
nmap <leader>l :set list!<CR>
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
" Invisible character colors
highlight CursorLineNr cterm=none ctermfg=0 guifg=#073642
highlight NonText cterm=none ctermfg=0 guifg=#073642
highlight SpecialKey cterm=none ctermfg=0 guifg=#073642 ctermbg=8 guibg=#002b36

" Highlight trailing whitespaces, but not while
" typing in insert mode
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/
