" Filetype/Language specific settings

" add syntax support for unrecognized file extensions
augroup filetypedetect
  au BufNewFile,BufRead .z* setf zsh
  au BufNewFile,BufRead *.as setf actionscript
  au BufNewFile,BufRead *.m setf objc
augroup END

" matching params for different languages
augroup clang
  autocmd FileType xml,html set mps+=<:>
  autocmd FileType c,cpp,java set mps+==:;
  " auto set filetype based on file name
  autocmd BufWinEnter,BufRead,BufNewFile Gruntfile set ft=javascript
  " au BufWinEnter,BufRead,BufNewFile *.md set ft=markdown
  autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown set filetype=markdown
augroup END

" Turn off incorrect syntax highlighting for $(...) syntax in .sh files
augroup sh_syntax
    autocmd!
    autocmd Syntax sh syn region shCommandSub matchgroup=shCmdSubRegion
        \ start="\$("  skip='\\\\\|\\.' end=")"
        \ contains=@shCommandSubList
    autocmd Syntax sh syn region shArithmetic matchgroup=shArithRegion
        \ start="\$((" skip='\\\\\|\\.' end="))"
        \ contains=@shArithList
augroup END
" let g:is_posix = 1 " sets all shell scripts syntax highlight to use POSIX

