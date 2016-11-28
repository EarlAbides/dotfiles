if exists(":NERDTreeTabsToggle")
  noremap <silent> <F10> :NERDTreeTabsToggle<CR>
  " find current file on nerdtree and then focus back on file editing
  noremap <silent> <F11> :NERDTreeTabsFind<CR>:wincmd p<CR>
  noremap! <silent> <F10> <ESC>:NERDTreeTabsToggle<CR>
elseif exists(":NERDTree")
  " maps NERDTree to F10
  noremap <silent> <F10> :NERDTreeToggle<CR>
  " find current file on nerdtree and then focus back on file editing
  noremap <silent> <F11> :NERDTreeFind<CR>:wincmd p<CR>
  noremap! <silent> <F10> <ESC>:NERDTreeToggle<CR>
  " tells NERDTree to use ASCII chars
endif

" common NERDTree and NERDTreeTabs configuration
if exists(":NERDTree")
  " How can I close vim if the only window left open is a NERDTree?
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
endif

