set nocompatible
set encoding=utf-8
scriptencoding utf-8

" options
set fileencoding=utf-8
set fileformat=unix
set number
set relativenumber
set nowrap
set display=
set autoindent
set tabstop=4
set expandtab
set shiftwidth=4
set nobackup
set noswapfile
set noundofile
set ignorecase
set smartcase
set infercase
set nrformats=
set foldmethod=marker
set cursorline
set nocursorcolumn
set textwidth=0
set autochdir
set scrolloff=3
set sidescroll=1
set sidescrolloff=7
set visualbell
set t_vb=
set noerrorbells
set mouse=n
set winaltkeys=no
set iminsert=0
set imsearch=0

" packages
packadd matchit

" colorscheme and syntax
colorscheme ron
syntax on

" mapping
nnoremap <silent> // :<c-u>let v:hlsearch = !v:hlsearch<cr>
nnoremap <space>w :<c-u>update<cr>
nnoremap <space><space>w :<c-u>write!<cr>
nnoremap <space>q :<c-u>quit<cr>
nnoremap <space><space>q :<c-u>quit!<cr>
nnoremap <space><space><space>q :<c-u>quitall!<cr>
nnoremap <space>4 <s-$>
nnoremap <space>5 <s-%>
nnoremap <space>; :
nnoremap / /\v
nnoremap ? ?\v
nnoremap <silent> * :let [@/, v:hlsearch] = [printf('\<%s\>', expand('<cword>')), v:true]<cr>
nnoremap <silent> # :let [@/, v:hlsearch] = [printf('\<%s\>', expand('<cword>')), v:true]<cr>
nnoremap <silent> g* :let [@/, v:hlsearch] = [expand('<cword>'), v:true]<cr>
nnoremap <silent> g# :let [@/, v:hlsearch] = [expand('<cword>'), v:true]<cr>

" imitate moveme
nmap <silent> ,n :set lines+=1 columns+=2<cr>,
nmap <silent> ,m :set lines-=1 columns-=2<cr>,
nmap <silent> ,h :call execute(join(['winpos', getwinposx() - 10, getwinposy()     ]))<cr>,
nmap <silent> ,j :call execute(join(['winpos', getwinposx(),      getwinposy() + 10]))<cr>,
nmap <silent> ,k :call execute(join(['winpos', getwinposx(),      getwinposy() - 10]))<cr>,
nmap <silent> ,l :call execute(join(['winpos', getwinposx() + 10, getwinposy()     ]))<cr>,

" imitate completechar
let g:completechars = []
for completechar in split('!@#$%^&*()-_=+\|~?`', '\zs')
   call add(g:completechars, { 'word' : completechar })
endfor
unlet completechar
inoremap <silent> ,, <c-r>=CompleteChar()<cr>
function! CompleteChar()
   call complete(col(','), g:completechars)
   return ''
endfunction
inoremap <silent> ,u _
inoremap <silent> ,p +
inoremap <silent> ,m -
inoremap <silent> ,e =
inoremap <silent> ,b \

" imitate fixregister
augroup fixregister
   autocmd!
   autocmd BufEnter * :let @p = expand('%:p')
   autocmd BufEnter * :let @e = expand('%:e')
augroup END


" vim: set ts=3 sts=3 sw=3 et :
