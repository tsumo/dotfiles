filetype plugin indent on
syntax on
set modeline
au FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4

" size of hard tabstop
set tabstop=4

" size of an indent
set shiftwidth=4

" use spaces instead of tabs
set expandtab

" start searching as you type
set incsearch

" automatically ignore case for lowercase searches
" case-sensitive for searches with uppercase letters
set smartcase

" space opens/closes folds
set smartcase

" toggle auto-indenting for code paste
set pastetoggle=<F2>     

" mapping cyrillic layout for normal mode
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" ---Dealing with invisible characters---
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
