" Statusline settings


" set statusline=
" set statusline+=%<                       " cut at start
" set statusline=%{getcwd()}
" set statusline+=%=        " Switch to the right side
" set statusline+=%m%f  " Relative Path to the file
" set statusline+=\ %{strftime(\"%H:%M\")}
" set statusline+=\ [%p%%]   " percentage of how far down the cursor is in the buffer
" set statusline+=\ [%l/%L,%v]    " current line / total lines, current column
" set statusline+=\ [%n,%{len(filter(range(1,bufnr('$')),'buflisted(v:val)'))}]

set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" set statusline+=%5*%{&ff}%*            "file format
" set statusline+=%3*%y%*                "file type

" set statusline=%!SetStatusline()
function! SetStatusline()
  let stl = ' %4*%<%f%*'

  if exists('b:git_dir')
    let stl    .= '%3*:%*'
    let branch  = fugitive#head(8)
    let stl    .= (branch == 'master') ? '%1*master%*' : '%2*'. branch .'%*'
    let stl    .= mhi#sy_stats_wrapper()
  endif

  let stl .=
        \   '%m%r%h%w'
        \ . '%= '
        \ . '%#ErrorMsg#%{&paste ? " paste " : ""}%*'
      \ . '%#WarningMsg#%{&ff != "unix" ? " ".&ff." ":""}%* '
        \ . '%#warningmsg#%{&fenc != "utf-8" && &fenc != "" ? " ".&fenc." " :""}%* '

  if get(b:, 'stl_highlight')
    let id = synID(line('.'), col('.'), 1)
    let stl .=
          \   '%#WarningMsg#['
          \ . '%{synIDattr('.id.',"name")} as '
          \ . '%{synIDattr(synIDtrans('.id.'),"name")}'
          \ . ']%* '
  endif

  if get(b:, 'stl_location')
    let stl .=
          \   '%3*[%*%v%3*,%*%l%3*/%*%L%3*]%* '
          \ . '%p%3*%%%* '
  endif

  return stl
endfunction
