set shell=$SHELL

set nocompatible " iMproved

"===============
"=== PLUGINS ===
"===============

call plug#begin('~/.vim/plugged')

" general
Plug 'tpope/vim-fugitive' " git functions inside vim
Plug 'vim-airline/vim-airline' " powerline
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale' " linter
Plug 'andymass/vim-matchup' " matching parens and more
Plug 'neoclide/coc.nvim' " language server
Plug 'bronson/vim-trailing-whitespace' " highlight trailing spaces
Plug 'airblade/vim-gitgutter' " show added lines
Plug 'scrooloose/nerdcommenter' " commenting shortcuts
Plug 'rhysd/vim-grammarous' " grammar check

" search
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-eunuch' " wrappers UNIX commands
Plug 'tpope/vim-surround' " surround characters shortcuts
Plug 'tpope/vim-endwise' " adding closing commands in various languages
Plug 'tpope/vim-vinegar' " file browser

" testing
Plug 'kassio/neoterm' "terminal wrapper
Plug 'janko-m/vim-test' " testing commands

" javascript
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }
Plug 'posva/vim-vue', {'rev': 'performance-enhancement'} " Vue highlighting
Plug 'othree/javascript-libraries-syntax.vim'

" python
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
Plug 'numirias/semshi', { 'for': 'python' } " syntax highlight

" ruby
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'ecomba/vim-ruby-refactoring', { 'for': 'ruby' }
Plug 'tpope/vim-haml', { 'for': 'haml' }

" elixir
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
Plug 'mattreduce/vim-mix', { 'for': 'elixir' }
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }

call plug#end()

"===============
"=== SETTINGS ===
"===============

syntax enable
filetype plugin indent on     " required!

let mapleader = ","
let maplocalleader = "\\"

" File types {{{
au FileType python                  set ts=4 sw=4
au BufRead,BufNewFile *.md          set ft=mkd tw=80 syntax=markdown
au BufRead,BufNewFile *.ppmd          set ft=mkd tw=80 syntax=markdown
au BufRead,BufNewFile *.markdown    set ft=mkd tw=80 syntax=markdown
au BufRead,BufNewFile *.slimbars    set syntax=slim
" }}}

" Basic settings {{{
set encoding=utf-8
set backspace=indent,eol,start " backspace works on every character in insert mode
set completeopt=longest,menuone,preview
set history=1000
set dictionary=/usr/share/dict/words
" }}

" Mapping waiting time {{{
set notimeout
set ttimeout
set ttimeoutlen=100
" }}}

" Display {{{
set showmatch " show matching brackets
set scrolloff=3 " always show 3 rows from edge of the screen
set synmaxcol=300 " stop syntax highlight after x lines for performance
set laststatus=2 " always show status line

set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set nolist " do not display white characters
set nofoldenable
set foldlevel=4 " limit folding to 4 levels
set foldmethod=syntax " use language syntax to generate folds
set nowrap "do not wrap lines even if very long
set noeol " show if there's no eol char
set showbreak=↪ " character to show when line is broken
" }}}

" Sidebar {{{
set number " line number on the left
set numberwidth=3 " always reserve 3 spaces for line number
set signcolumn=yes " keep 1 column for coc.vim  check
set modelines=0
set showcmd " display command in bottom bar
" }}}

" Search {{{
set incsearch " starts searching as soon as typing, without enter needed
set ignorecase " ignore letter case when searching
set smartcase " case insentive unless capitals used in search
" ctrl-b to remove search highlighting
noremap <C-b> :noh<cr>:call clearmatches()<cr>

set matchtime=2 " delay before showing matching paren
set mps+=<:>

" fzf.vim mappings
noremap <C-p> :FZF<CR>
noremap <C-y> :Buffers<CR>
noremap <C-t> :Tags<CR>
"" search in files
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <leader>H :Commits<CR>
" }}}

" White characters {{{
set autoindent
set smartindent
set tabstop=2 " 1 tab = 2 spaces
set shiftwidth=2 " indentation rule
set formatoptions=qnj1 " q  - comment formatting; n - numbered lists; j - remove comment when joining lines; 1 - don't break after one-letter word
set expandtab " expand tab to spaces
" }}}

" Backup files {{{
set backup " use backup files
set noswapfile " do not use swap file
set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
" }}}

" Commands mode {{{
set wildmenu " on TAB, complete options for system command
set wildignore=deps,.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc
" }}}

" Only show cursorline in the current window and in normal mode.
augroup cline
    au!
    au WinLeave * set nocursorline
    au WinEnter * set cursorline
    au InsertEnter * set nocursorline
    au InsertLeave * set cursorline
augroup END

" sane regexes
nnoremap / /\v
vnoremap / /\v

" Don't jump when using * for search
nnoremap * *<c-o>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Open a Quickfix window for the last search.
nnoremap <silent> <leader>? :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Begining & End of line in Normal mode
noremap H ^
noremap L g_

" more natural movement with wrap on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Easy buffer navigation
noremap <C-h>  <C-w>h
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Color switch {{{
" switch theme to bright colors
function! MakeItLight()
    set background=light
    colorscheme Tomorrow
    hi ALEWarning cterm=underline
    hi ALEError cterm=underline ctermbg=DarkBlue
endfunction
command Light call MakeItLight()

" switch theme to dark colors
function! MakeItDark()
    set background=dark
    colorscheme Tomorrow-Night
    hi ALEWarning cterm=underline
    hi ALEError cterm=underline ctermbg=DarkGray
endfunction
command Dark call MakeItDark()
" }}}

" Quick editing
nnoremap <leader>ev <C-w>s<C-w>j:e $MYVIMRC<cr>
nnoremap <leader>es <C-w>s<C-w>j:e ~/.vim/snippets/<cr>
nnoremap <leader>eg <C-w>s<C-w>j:e ~/.gitconfig<cr>
nnoremap <leader>ez <C-w>s<C-w>j:e ~/.zshrc<cr>
nnoremap <leader>et <C-w>s<C-w>j:e ~/.tmux.conf<cr>

let g:rubycomplete_buffer_loading = 0
let g:rubycomplete_classes_in_global = 1

nnoremap <leader>cp :let @" = expand("%")<cr>

" Easy window split; C-w v -> vv, C-w - s -> ss
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s
set splitbelow " when splitting horizontally, move coursor to lower pane
set splitright " when splitting vertically, mnove coursor to right pane

" home and end line in command mode
cnoremap <C-a>  <Home>
cnoremap <C-e>  <End>

" vim-test {{{
" test-vim custom strategy
function! NeotermTest(cmd)
  if g:neoterm.has_any()
    let l:id = g:neoterm.last_id
    let l:instance = g:neoterm.instances[l:id]
    if bufwinnr(l:instance.buffer_id) <= 0
      execute "split"
      execute "resize 20"
      call neoterm#open({ 'target': l:id })
    endif
    call neoterm#do({ 'cmd': a:cmd, 'target': l:id })
  else
    execute "split"
    execute "resize 20"
    execute "enew"
    call neoterm#new()
    call neoterm#do({ 'cmd': a:cmd })
  endif
endfunction

" test-vim mappings
let g:test#custom_strategies = {'CustomNeotermStrategy': function('NeotermTest')}
let g:test#strategy = 'CustomNeotermStrategy'
let test#strategy = "CustomNeotermStrategy"
let g:test#preserve_screen = 1
nnoremap <leader>t :TestNearest<CR>
nnoremap <leader>T :TestFile<CR>
nnoremap <leader>A :TestSuite<CR>
nnoremap <leader>l :TestLast<CR>
nnoremap <leader>g :TestVisit<CR>
let g:neoterm_autoscroll = 1 " always scroll to the end of the command output
" }}}

" coc.nvim settings {{{
" set tab to complete phrase
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
nnoremap <silent> K :call <SID>show_documentation()<CR>

" gd - go to definition of word under cursor
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)

" gi - go to implementation
nmap <silent> gi <Plug>(coc-implementation)

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" }}}

" CTags {{{
" ruby ctags including depencendies
nnoremap <leader>ctr :!ctags --exclude=node_modules --exclude=public --exclude=vendor -R . $(bundle list --paths) <CR>
" general app-only ctags
nnoremap <leader>ct :!ctags --exclude=node_modules --exclude=public --exclude=vendor -R . <CR>
nnoremap <leader>n :tnext<CR>
nnoremap <leader>b :tprevious<CR>
" }}}

" Terminal {{{
" ESC to go to normal mode in terminal
tnoremap <C-s> <C-\><C-n>
" }}}

" Vue.js
let g:vue_disable_pre_processors = 1 " speed up vim-vue
autocmd FileType vue syntax sync fromstart "ensure highlighting works

set background=dark
colorscheme Tomorrow-Night

let g:ale_set_highlights = 1

" Fix spelling error colors {{{
" underline instead of highlighting errors
hi clear SpellBad
hi clear SpellCap
hi SpellBad cterm=underline
hi SpellCap cterm=underline

hi ALEWarning cterm=underline
hi ALEError cterm=underline ctermbg=DarkGray
" }}}

let g:ale_linters = {
      \   'python': ['flake8'],
      \   'ruby': ['rubocop'],
      \   'javascript': ['eslint'],
      \}
