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
if has('packages')
   packadd matchit
endif

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

" imitate completion
"let s:completechars = map(split('!@#$%^&*()-_=+\|~?`', '\zs'), {idx, val -> { 'word': val } })
let s:completechars = map(split('!@#$%^&*()-_=+\|~?`', '\zs'), '{ "word": v:val }')
call add(s:completechars, { 'word': '	', 'abbr': '[htab]' }) " horizontal-tab
call add(s:completechars, { 'word': '', 'abbr': '[vtab]' }) " vertical-tab
inoremap <silent> ,, <c-r>=<sid>complete_char()<cr>
function! s:complete_char()
   call complete(col('.'), s:completechars)
   return ''
endfunction
inoremap <silent> ,d <c-r>=<sid>complete_date()<cr>
function! s:complete_date()
   let localtime = localtime()
   call complete(col('.'), [
            \ strftime('%Y-%m-%d', localtime),
            \ strftime('%Y%m%d', localtime),
            \ strftime('%Y/%m/%d', localtime)
            \ ])
   return ''
endfunction
inoremap <silent> ,t <c-r>=<sid>complete_time()<cr>
function! s:complete_time()
   let localtime = localtime()
   call complete(col('.'), [
            \ strftime('%H:%M', localtime),
            \ strftime('%H%M', localtime)
            \ ])
   return ''
endfunction
inoremap <silent> ,u _
inoremap <silent> ,p +
inoremap <silent> ,m -
inoremap <silent> ,e =
inoremap <silent> ,b \

" imitate chilimarker
nnoremap <nowait><silent> <space>c :<c-u>call <sid>chilimarker()<cr>
nnoremap <nowait><silent> <space><space>c :set colorcolumn&<cr>
function! s:chilimarker()
   let list = split(&colorcolumn, ',')
   let col = col('.') + s:offset . ''
   if count(list, col)
      call remove(list, index(list, col))
   else
      call add(list, col)
   endif
   let &l:colorcolumn = join(list, ',')
endfunction


" vim: set ts=3 sts=3 sw=3 et :
