set encoding=utf-8
scriptencoding utf-8

" options
set fileencoding=utf-8
set fileformat=unix
set number
set relativenumber
set nowrap
set display=lastline
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
set sidescrolloff=3
set visualbell
set t_vb=
set mouse=n
set winaltkeys=no

" packages
packadd matchit

" colorscheme and syntax
colorscheme desert
syntax on

" mapping
nnoremap <silent> // :<C-u>let v:hlsearch = !v:hlsearch<CR>
nnoremap <Space>w :<C-u>update<CR>
nnoremap <Space><Space>w :<C-u>write!<CR>
nnoremap <Space>q :<C-u>quit<CR>
nnoremap <Space><Space>q :<C-u>quit!<CR>
nnoremap <Space><Space><Space>q :<C-u>quitall!<CR>
nnoremap <Space>4 <S-$>
nnoremap <Space>5 <S-%>
nnoremap <Space>; :
nnoremap / /\v
nnoremap ? ?\v

" imitate moveme
nmap <silent> ,n :set lines+=1 columns+=2<CR>,
nmap <silent> ,m :set lines-=1 columns-=2<CR>,
nmap <silent> ,h :call execute(join(['winpos', getwinposx() - 10, getwinposy()     ]))<CR>,
nmap <silent> ,j :call execute(join(['winpos', getwinposx(),      getwinposy() + 10]))<CR>,
nmap <silent> ,k :call execute(join(['winpos', getwinposx(),      getwinposy() - 10]))<CR>,
nmap <silent> ,l :call execute(join(['winpos', getwinposx() + 10, getwinposy()     ]))<CR>,

" imitate completechar
let g:completechars = []
for completechar in split('!@#$%^&*()-_=+\|~?`', '\zs')
   call add(g:completechars, { 'word' : completechar })
endfor
unlet completechar
inoremap <silent> ,, <C-R>=CompleteChar()<CR>
function! CompleteChar()
   call complete(col(','), g:completechars)
   return ''
endfunction

" imitate fixregister
augroup fixregister
   autocmd!
   autocmd BufEnter * :let @p = expand('%:p')
   autocmd BufEnter * :let @e = expand('%:e')
augroup END


" vim: set ts=3 sts=3 sw=3 et :
