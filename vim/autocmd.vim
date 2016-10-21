" Autocmds sourced by ~/.vimrc

" Cursor at position of last saved line when opening file
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" Extra white spaces display
hi ExtraWhitespace guibg=#CCCCCC
hi ExtraWhitespace ctermbg=161
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Vim-Galore suggested settings
" toggle cursorline whenc changing modes
autocmd WinEnter    * set cursorline
autocmd WinLeave    * set nocursorline
autocmd InsertEnter * set nocursorline
autocmd InsertLeave * set cursorline

" matching params for different languages
autocmd FileType xml,html set mps+=<:>
autocmd FileType c,cpp,java set mps+==:;

" Vim-Signature settings
" display Signature even if there is no marks
" sign define Dummy
" autocmd VimEnter * bufdo execute 'sign place 21358 line=1 name=Dummy buffer=' . bufnr('%')
" autocmd BufNew   * execute 'sign place 21358 line=1 name=Dummy buffer=' . bufnr('%')
