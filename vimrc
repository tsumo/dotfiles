" Lines of command history to remember
set history=700

" Enabling filetype plugins
filetype plugin on
filetype indent on

" Syntax highlighting
syntax on

" Enables per-file formatting guidelines
set modeline

" Line numbering
set number

" Auto indent
set ai

" Smart indent
set si

" Wrap lines
set wrap

" Show tabs as n spaces
set tabstop=4

" Incomprehensible magic thingy
" Allows to delete 4 spaces with one backspace press
set softtabstop=4

" Indent size
set shiftwidth=4

" Tab key inserts spaces
set expandtab

" Defines the number of context lines visible above and below cursor
set scrolloff=3

" Show all command autocompletion suggestions
set wildmenu
set wildmode=longest:full,full

" Start searching as you type
set incsearch

" Highlight search patterns
set hlsearch

" Automatically ignore case for lowercase searches,
" case-sensitive for searches with uppercase letters
set smartcase

" Toggle auto-indenting for code paste in normal mode
nnoremap <F2> :set invpaste paste?<CR>
" and in insert mode
set pastetoggle=<F2>

" mapping cyrillic layout for normal mode
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" Navigating inside long lines
map j gj
map k gk

" Breaking habits
noremap <up> <NOP>
noremap <down> <NOP>
noremap <left> <NOP>
noremap <right> <NOP>

" Remember last cursor position when opening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Moving lines up and down with Ctrl+[jk]
nmap <C-k> ddkP
nmap <C-j> ddp

" ---Invisible characters---
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
