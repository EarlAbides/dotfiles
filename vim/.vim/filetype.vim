" Determine the "type" of a file.
" http://vim.wikia.com/wiki/Filetype.vim
autocmd BufRead,BufNewFile *.coffee setlocal ft=coffee
autocmd BufRead,BufNewFile *.json setlocal ft=json
autocmd BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown
autocmd BufRead,BufNewFile *.{conf} set filetype=config
autocmd BufRead,BufNewFile README set filetype=readme
" asciidoc and asciidoctor
autocmd BufRead,BufNewFile *.adoc,*.asciidoc setlocal filetype=asciidoc
