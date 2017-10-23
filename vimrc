set history=1000    " Lines of command history to remember

syntax on           " Syntax highlighting

set tabstop=4       " Show tabs as n spaces
set softtabstop=4   " Number of spaces to insert with TAB or delete with BS
set expandtab       " Insert n spaces instead tab
set shiftwidth=4    " Indent size for normal mode commands

set autoindent      " Copy indent from current line to new line
set smartindent

filetype plugin on
filetype indent on  " Load file-specific indent files

" Place to store .swp files
" Double slash protects from filename conflicts
set directory=~/.vim/tmp//,/var/tmp//,/tmp//

"====
" UI
"====
" Absolute line numbers for insert mode and unfocused windows
" Relative line numbers for normal mode
set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

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
" Fix slow O inserts
set timeout timeoutlen=1000 ttimeoutlen=100

"============
" STATUSLINE
"============
" Shortcut '\g' to toggle current git branch in statusline
nmap <leader>g :call StatuslineGitToggle()<CR>

function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

let g:StatuslineGitIsOn = 1

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
        return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
    endif
    return ''
endfunction

set statusline=
set statusline+=%{StatuslineGit()}  " git branch
set statusline+=%<%f\ (%{&ft})      " filename, filetype
set statusline+=\ %-4(%m%)          " modified flag
set statusline+=%=%-19(%3l,%02c%03V%)   " ruler

"========
" SEARCH
"========
set incsearch       " Start searching as you type
set hlsearch        " Highlight search patterns
" Automatically ignore case for lowercase searches,
" case-sensitive for searches with uppercase letters
set smartcase

" Toggle auto-indenting for code paste in normal mode
nnoremap <F2> :set invpaste paste?<CR>
" and in insert mode
set pastetoggle=<F2>

" mapping cyrillic layout for normal mode
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" Moving lines up and down with Ctrl+up/down
nmap <C-Up> ddkP
nmap <C-Down> ddp

" Navigating between splits with Ctrl+hjkl
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Up and Down navigate inside long lines
" Left and Right scroll window, keeping cursor
" in the same line on screen
" No arrow keys in insert and visual
noremap <up> gk
noremap <down> gj
noremap <left> <C-y>gk
noremap <right> <C-e>gj
inoremap <up> <NOP>
inoremap <down> <NOP>
inoremap <left> <NOP>
inoremap <right> <NOP>
vnoremap <up> <NOP>
vnoremap <down> <NOP>
vnoremap <left> <NOP>
vnoremap <right> <NOP>

" Remember last cursor position when opening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

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

