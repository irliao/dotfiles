" Autocmds sourced by ~/.vimrc

" NOTE: Indent size set by FileType autocmd replaced with ~/.editorconfig (symlinked to ~/.dotfiles/vim/editorconfig.conf)

" Cursor at position of last saved line when opening file
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" Extra white spaces display
" hi ExtraWhitespace guibg=#CCCCCC
" hi ExtraWhitespace ctermbg=161
" match ExtraWhitespace /\s\+$/
" autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" autocmd BufWinLeave * call clearmatches()

" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
autocmd BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
autocmd InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/

" exit Insert mode if window lost focus
autocmd FocusLost * stopinsert

" Vim-Galore suggested settings
" toggle cursorline whenc changing modes
augroup cline
  autocmd!
  autocmd WinEnter    * set cursorline
  autocmd WinLeave    * set nocursorline
  autocmd InsertEnter * set nocursorline
  autocmd InsertLeave * set cursorline
augroup END

augroup cnumber
  autocmd!
  " show absolute number when Vim loses focus, relative when Vim gains focus
  autocmd FocusLost * :set norelativenumber
  autocmd FocusGained * :set relativenumber
  " show absolute number in Insert mode, relative in Normal mode
  autocmd InsertEnter * :set norelativenumber
  autocmd InsertLeave * :set relativenumber
augroup END

" TODO: make into toggle/function (highlight looks nice, but not for files wit many lines longer than 80 chars)
" highlight characters past 80 column
" augroup vimrc_autocmds
"   autocmd BufEnter * highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
"   autocmd BufEnter * match OverLength /\%80v.*/
" augroup END

" TODO: investigate if this augroup can fix IncSearch binded to 'nmap n <Plug>(incsearch-forward)'
" Style and behaviour customizations for certain modes and window types.
" augroup styleAndBehaviourCustomizations
"     autocmd!
"     autocmd VimEnter,WinEnter,BufWinEnter,InsertLeave * call WindowFocus("Enter")
"     autocmd WinLeave,FilterWritePost * call WindowFocus("Leave")
"     autocmd InsertEnter * call InsertMode(v:insertmode)
"     autocmd CursorMoved * call VisualMode()
"     autocmd BufWinEnter quickfix setlocal cursorline colorcolumn=0
"     autocmd FileType nerdtree setlocal conceallevel=0 colorcolumn=0
"     autocmd FilterWritePre * call Styling()
"     if v:progname != "vi"
"         autocmd FileType * IndentLinesReset
"     endif
" augroup END

" Vim-Signature settings
" display Signature even if there is no marks
" sign define Dummy
" autocmd VimEnter * bufdo execute 'sign place 21358 line=1 name=Dummy buffer=' . bufnr('%')
" autocmd BufNew   * execute 'sign place 21358 line=1 name=Dummy buffer=' . bufnr('%')
