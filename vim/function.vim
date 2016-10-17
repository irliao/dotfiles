" Functions sourced by vimrc

" Toggle highlight from search
function! ToggleHighlight ()
  set hlsearch! hlsearch?
endfunction

" Toggle cross highlight at cursor
function! ToggleCursorCross ()
  if &cursorline && &cursorcolumn
    set nocursorline
    set nocursorcolumn
  else
    set cursorline
    highlight CursorLine ctermbg=Red
    set cursorcolumn
    highlight CursorColumn ctermbg=Red
  endif
endfunction

" Diff current file against saved version
function! DiffWithSaved ()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction

" TODO: create key binding for this
function! StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
function! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
" WARN: uncomment out lines below to auto call function above for specified file type
" autocmd BufWrite *.py :call DeleteTrailingWS()
" autocmd BufWrite *.coffee :call DeleteTrailingWS()

function! ShowListChar()
" TODO: make this toggleable
" set list " show trailing spaces and tabs as chars
" set listchars=tab:▸\ ,eol:¬
endfunc

" Command-T build
function! BuildCommandT(info)
  " build C extension required
  !cd ~/.vim/bundle/command-t/ruby/command-t
  !ruby extconf.rb
  !make
endfunction

" YouCompleteMe build
" @param name - name of the plugin
" @param status - 'installed', 'updated', or 'unchanged'
" @param force - set on PlugInstall! or PlugUpdate!
function! BuildYCM(info)
    if a:info.status == 'installed' || a:info.force
        !./install.py --clang-completer --tern-completer
    endif
endfunction
