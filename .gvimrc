set encoding=utf-8
scriptencoding utf-8

" options
set t_vb=
set guioptions=
set shortmess+=I
set mouse=n

" colorscheme
colorscheme desert

" font
if has('win32')
   set guifont=Consolas:h12:b:cANSI:qDRAFT
   set guifontwide=HGｺﾞｼｯｸE:h12:cANSI:qDRAFT
elseif has('mac')
   set guifont=Osaka－等幅:h14
elseif has('unix')
   " TODO: detect
   set guifont=
endif


" vim: set ts=3 sts=3 sw=3 et :
