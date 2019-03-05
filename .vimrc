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
set viminfo=
set ignorecase
set smartcase
set infercase
set nrformats=
set formatoptions=roqnMj
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
colorscheme desert
syntax on

" mapping
let mapleader = "\<space>"
nnoremap <leader>w :<c-u>update<cr>
nnoremap <leader><leader>w :<c-u>write!<cr>
nnoremap <leader>q :<c-u>quit<cr>
nnoremap <leader><leader>q :<c-u>quit!<cr>
nnoremap <leader><leader><leader>q :<c-u>quitall!<cr>
nnoremap <leader>4 <s-$>
nnoremap <leader>5 <s-%>
nnoremap <leader>; :
nnoremap <silent> // :<c-u>let v:hlsearch = !v:hlsearch<cr>
nnoremap <silent> ?? //
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
nnoremap <nowait><silent> <space><space>c :let &l:colorcolumn=<cr>
function! s:chilimarker()
   let list = split(&l:colorcolumn, ',')
   let col = col('.') . ''
   if count(list, col)
      call remove(list, index(list, col))
   else
      call add(list, col)
   endif
   let &l:colorcolumn = join(list, ',')
endfunction

" imitate visualplus
xnoremap zz :VScrollMiddle<cr>
command! -range VScrollMiddle :call <sid>V_zz(<line1>, <line2>, <count>)
function! s:V_zz(line1, line2, count)
   let mid = (a:line2 - a:line1 + 1) / 2
   call execute(a:line2 - mid)
   normal! zz
   normal! gv
endfunction
xnoremap zf :VMakeFoldMarker<cr>
command! -range VMakeFoldMarker :call <sid>V_zf(<line1>, <line2>, <count>)
function! s:V_zf(line1, line2, count)
   if &foldmethod == 'manual'
      setlocal foldenable
      normal! gvzf
   elseif &foldmethod == 'marker'
      setlocal foldenable
      let fm = split(&foldmarker, ',')
      call append(a:line2    , printf(&commentstring, fm[1]))
      call append(a:line1 - 1, printf(&commentstring, fm[0]))
      normal! '<km<
      normal! '>jm>
      normal! gv=
   endif
endfunction
vnoremap <silent> < :<c-u>call <sid>V_sl('<')<cr>
vnoremap <silent> > :<c-u>call <sid>V_sl('>')<cr>
function! s:V_sl(ward)
   execute 'normal!' 'gv' . v:count1 . a:ward
   normal! gv
endfunction


" vim: set ts=3 sts=3 sw=3 et :
