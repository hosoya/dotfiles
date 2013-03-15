" vim-powerline
"let g:Powerline_symbols='fancy'

" general

" edit
set smartindent
"set paste
autocmd FileType c setlocal cindent
"set hidden
"set nrformats-=octal
"set backspace=2
"set autoread
"set splitright
"set splitbelow

" disp
syntax on
set number
set nowrap
set showmatch
set title
set ruler
set showcmd
set laststatus=2
set wildmenu
set wildmode=list:longest,full
set listchars=tab:\|-,trail:\|

set t_Co=256
set background=dark
"colorscheme molokai

" status line
set statusline =[%n]
set statusline+=%<%f
set statusline+=%m
set statusline+=%r
set statusline+=%w
set statusline+=[%{&fileformat}]
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]
set statusline+=%y
set statusline+=%=
set statusline+=[%B,%c]
set statusline+=[%l/%L]
set statusline+=\%3.3p%%

" search
set nohlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan

" tab
"set smarttab
"set tabstop=2
"set softtabstop=2
"set shiftwidth=2
autocmd BufNewFile,BufRead * call SetTab()
function! SetTab()
  if (&syntax == 'c' || &syntax == 'cpp' || &syntax == 'perl' || &syntax == 'python' || &syntax == 'make')
  set noexpandtab
  set shiftwidth=8
  set tabstop=8
  set softtabstop=8
  elseif (&syntax == 'changelog')
  set noexpandtab
  set shiftwidth=2
  set tabstop=2
  set softtabstop=2
  else
  set expandtab
  set shiftwidth=2
  set tabstop=2
  set softtabstop=2
  endif
endf

" japanese
"set encoding=japan
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,sjis,euc-jp

" fileformat
set fileformat=unix
set fileformats=unix,dos,mac
set noswapfile

"" keymap
" buffer command
"map <UP>    :buffers<CR>:buffer 
"map <DOWN><DOWN>  :bdelete<CR>
"map <LEFT>  :bprevious<CR>
"map <RIGHT> :bnext<CR>
" file save command
"noremap ZZ <Esc>
"noremap  <C-F> :write<CR>
"inoremap <C-F> <Esc>mm:write<CR>`ma
"noremap  <C-C> :quit<CR>
" tag jump command
"map <C-J> g<C-]>
"map <C-H> <C-T>
"map <C-K> <C-W>]
" tab command
"nnoremap <C-Tab>   gt
"nnoremap <C-S-Tab> gT 
" always mode insert tab
"noremap <Tab> i<Tab><Esc>
" toggle highlight search when searching
"nnoremap <Esc><Esc> :<C-u>set nohlsearch<Return>
nnoremap / :<C-u>set hlsearch<Return>/
nnoremap ? :<C-u>set hlsearch<Return>?
nnoremap * :<C-u>set hlsearch<Return>*
nnoremap # :<C-u>set hlsearch<Return>#

"" [macro] kill line end space
"map <F7> mm:%s/\s\+$//e<CR>'m
"" [macro] change one line comment
"map <F8> mm:%s/\/\/\s*\(.*\)\s*$/\/* \1 *\//e<CR>'m
