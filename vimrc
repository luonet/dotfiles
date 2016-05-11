"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimproc.vim'
" Plugin 'Shougo/vimshell.vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'Shougo/neosnippet'

Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
" Plugin 'tpope/vim-vividchalk'

Plugin 'vim-ruby/vim-ruby'
Plugin 'vim-scripts/matchit.zip'
Plugin 'vim-scripts/tComment'
" Plugin 'vim-scripts/DrawIt'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/syntastic'
Plugin 'junegunn/vim-easy-align'
Plugin 'majutsushi/tagbar'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'mhinz/vim-signify'
Plugin 'honza/vim-snippets'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'mbbill/undotree'
Plugin 'jiangmiao/auto-pairs'
Plugin 'gregsexton/gitv'
Plugin 'elixir-lang/vim-elixir'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'fatih/vim-go'
call vundle#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
filetype plugin indent on
compiler ruby
scriptencoding utf-8

set autoindent
set hlsearch
set incsearch
set number
set ruler
set showcmd
set expandtab
set splitright
set diffopt+=vertical
set tabstop=2 shiftwidth=2 softtabstop=2
set list listchars=tab:»·,trail:·,nbsp:·
match Error /\t/
2match Error / /
set laststatus=2
set wildmenu
set wildmode=list:longest,list:full
set encoding=utf-8
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set termencoding=utf-8
set tags=./tags;$HOME
set nobackup
set noswapfile

if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

autocmd BufNewFile,BufRead *.html.erb set filetype=html.eruby

" gofmt formats everything for you
au FileType c,cpp,go setl noexpandtab nolist ts=4 sw=4 sts=4

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" basic key mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap j gj
nnoremap k gk
nnoremap / /\v
vnoremap / /\v

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

runtime! macros/matchit.vim

function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] =~ '\s'
    return "\<Tab>"
  else
    return "\<C-n>"
  endif
endfunction
inoremap <Tab>   <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-p>

let mapleader = " "

nnoremap <leader><leader>   <c-^>
nnoremap <silent> <leader>w <C-w>v<C-w>l
nnoremap <silent> <leader>d :noh<CR>
nnoremap <silent> <leader>q :q<CR>
nnoremap <silent> <leader>b :Tagbar<CR>
nnoremap <silent> <leader>c :VimShell<CR>
nnoremap <silent> <leader>u :UndotreeToggle<CR>

function! MyToggleNERDTreeFind()
  if g:NERDTree.IsOpen()
    NERDTreeClose
  else
    NERDTreeFind
  endif
endfunction
noremap <silent> <leader>t :call MyToggleNERDTreeFind()<CR>

function! s:ZoomToggle() abort
  if exists('t:zoomed') && t:zoomed
    execute t:zoom_winrestcmd
    let t:zoomed = 0
  else
    let t:zoom_winrestcmd = winrestcmd()
    resize
    vertical resize
    let t:zoomed = 1
  endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <leader>o :ZoomToggle<CR>

vmap <Enter> <Plug>(EasyAlign)
nmap ga      <Plug>(EasyAlign)

let g:vimshell_editor_command='/usr/local/bin/vim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" unite
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <C-p>     :<C-u>Unite -start-insert file_rec/async:!<CR>
nnoremap <leader>f :<C-u>Unite -start-insert file_rec/async:!<CR>
nnoremap <Leader>s :<C-u>Unite -auto-preview grep:.<CR>
nnoremap <leader>e :<C-u>Unite  buffer bookmark<CR>
nnoremap <leader>r :<C-u>Unite  file_mru<CR>
nnoremap <leader>y :<C-u>Unite  history/yank<CR>
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  set number
  imap <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <buffer> <C-k> <Plug>(unite_select_previous_line)
endfunction
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
        \ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
        \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_rec_async_command =
        \ 'ag --follow --nocolor --nogroup --hidden -g ""'
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neocomplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 2
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
endfunction
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"<C-l> never works: https://github.com/Shougo/neocomplete.vim/issues/334
inoremap <C-l> <C-x><C-o>
inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"
autocmd FileType ruby       setlocal omnifunc=rubycomplete#Complete
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html       setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css        setlocal omnifunc=csscomplete#CompleteCSS
" if !exists('g:neocomplete#force_omni_input_patterns')
"   let g:neocomplete#force_omni_input_patterns = {}
" endif
" let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neosnippet
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable the default snippets: https://github.com/spf13/spf13-vim/issues/539
let g:neosnippet#disable_runtime_snippets = { "_": 1, }
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
imap <expr><C-j> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<C-j>"
smap <expr><C-j> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<C-j>"
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" easymotion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase  = 1
map f <Plug>(easymotion-bd-w)
map F <Plug>(easymotion-sn)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('gui_running')
  set background=light
  colorscheme solarized
  highlight SignifySignAdd    gui=bold guibg=NONE guifg=#009900
  highlight SignifySignDelete gui=bold guibg=NONE guifg=#ff2222
  highlight SignifySignChange gui=bold guibg=NONE guifg=#bbbb00
else
  set background=dark
  let g:solarized_termtrans=1
  let g:solarized_termcolors=256
  colorscheme solarized
  highlight SignifySignAdd    cterm=bold ctermbg=NONE ctermfg=119
  highlight SignifySignDelete cterm=bold ctermbg=NONE ctermfg=167
  highlight SignifySignChange cterm=bold ctermbg=NONE ctermfg=227
endif
highlight clear SignColumn
