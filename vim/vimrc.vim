" Vim Configs
set nocompatible " vi improved, required
" WARN: remove any [filetype off, filetype plugin indent on, syntax on], already included by vim-plug

" WARN: source order matters
source ~/.vim/function.vim
source ~/.vim/plugin.vim
source ~/.vim/set.vim
source ~/.vim/scheme.vim
source ~/.vim/autocmd.vim
source ~/.vim/map.vim

" SuperTab settings
let g:SuperTabDefaultCompletionType = "<c-n>" " <Tab> completion going -down- list

" Startify settings
" WARN: avoid mapping to Startify reserved keys q,e,i,b,s,v,t,<cr>
autocmd User Startified setlocal cursorline
autocmd User Startified map <buffer> , <CR> t<CR> " press ',' in Startify to open as tab
autocmd User Startified nmap <buffer><CR> t:call startify#open_buffers()<CR> " open files in tab by default
let g:startify_enable_special = 0 " disable showing empty/quit buffers
let g:startify_change_to_dir = 1
let g:startify_files_number = 8
let g:startify_relative_path = 1
let g:startify_update_oldfiles = 1
let g:startify_use_env = 1
let g:startify_list_order = [
  \ ['   Recents - all:'],
  \ 'files',
  \ ['   Recents - current directory :'],
  \ 'dir',
  \ ['   Bookmarks:'],
  \ 'bookmarks',
  \ ['   Commands:'],
  \ 'commands',
\ ]
let g:startify_skiplist = [
  \ 'COMMIT_EDITMSG',
  \ 'bundle/.*/doc',
\ ]
let g:startify_bookmarks = [
  \ { 'c' : '~/.vim/vimrc.vim' },
  \ { 'd' : '~/.dotfiles' },
\ ]
let g:startify_transformations = [
  \ ['.*vimrc$', 'vimrc'],
  \ ['.*zshrc$', 'zshrc'],
\ ]
let g:startify_commands = [
  \ ':help reference',
  \ ['Vim Reference', 'h ref'],
  \ {'h': 'h ref'},
  \ {'m': ['My magical function', 'call Magic()']},
\ ]
redir => header_prompt
  silent pwd
redir END
let g:startify_custom_header = map(split(header_prompt), 'repeat(" ", 3) . v:val')
let g:nyan = [
      \ '-_-_-_-_-_-_-_,------,',
      \ '_-_-_-_-_-_-_-|   /\_/\',
      \ '-_-_-_-_-_-_-~|__( ^ .^)',
      \ '_-_-_-_-_-_-_-""  ""']
" let g:startify_custom_footer = map(startify#fortune#boxed() + g:nyan, '"   ".v:val')
let g:startify_custom_footer = map(g:nyan, '"   ".v:val')

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
    \ 'mode': 'passive',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': []
\}
let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_javascript_standard_exec = 'semistandard'
let g:syntastic_bash_checkers=['shellcheck']
" syntastic binding
nnoremap <leader>sp :lprevious<CR> " go to previous error from Syntastic check, use ':lnext" for next error
" nnoremap <leader>\| :lclose<CR> " close error panel from Syntastic check TODO: check if this can be done using SyntasticToggle instead
" NOTE: uncomment two lines below to auto lint on save
" autocmd bufwritepost *.js silent !semistandard % --format
" set autoread

" Airline settings... mainly used to enable tab switch with map keys
let g:airline_theme='term' " use 'badwolf' for high contrast
let g:airline#extensions#tabline#show_buffers = 0 " hide buffers (prevents closed buffer showing in tab list)
let g:airline#extensions#tabline#enabled = 1 " displays all buffers (WARN: even if closed) if only one tab, required for tabline numbering to work
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#fnamemod = ':t' " show filename omitting filepath
let airline#extensions#default#section_use_groupitems = 0 " disable grouping to prevent bleeding UI
" let g:airline#extensions#default#section_truncate_width = {} " disable truncation
let g:airline#extensions#tabline#tab_nr_type = 1 " display only tab number
let g:airline#extensions#bufferline#enabled = 0 " disable bufferline
let g:airline#extensions#tabline#exclude_preview = 0 " disable display preview window buffer
let g:airline#extensions#tabline#buffer_nr_show = 0 " hide buffer numbers
let g:airline#extensions#tabline#tab_min_count = 2 " less than 2 tabs will not show tabline, WARN: only applies when 'show_buffer' is false
let g:airline#extensions#tabline#show_splits = 0 " show open splits as panes instead of new tab (more like Tmux)
let g:airline#extensions#tabline#show_tab_nr = 1 " display tab number in tabs mode
let g:tmuxline_powerline_separators = 0 " disable using powerline symbols

" Ctrl-P settings
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_match_window = 'bottom,order:ttb' " match top to bottom
let g:ctrlp_switch_buffer = 0 " always open files in new buffer
let g:ctrlp_working_path_mode = 0 " auto change directory with session
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""' " does not work with ctrlp_show_hidden and ctrlp_custom_ignore
let g:ctrlp_max_height = 5
let g:ctrlp_max_files=20000
let g:ctrlp_max_depth=20

" Silver Searcher settings
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor " Use ag over grep
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""' " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_use_caching = 0 " ag is fast enough that CtrlP doesn't need to cache
endif

" Airline tabline numbering
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>= <Plug>AirlineSelectNextTab

" toggle plugin binding
nnoremap <leader><Space> :NERDTreeToggle<CR> " similar to Tmux side-tree
" WARN: make sure '<leader>t' is not mapped to use the following mappings
nnoremap <leader>ti :IndentLinesToggle<CR>
nnoremap <leader>tl :set rnu!<CR>
nnoremap <leader>tm :SignatureToggle<CR>
nnoremap <leader>tmc :delmarks!<CR>:SignatureRefresh<CR> " clear and refresh marks for current buffer
nnoremap <leader>tmr :SignatureRefresh<CR>
nnoremap <leader>tn :Startify<CR>
nnoremap <leader>tt :TagbarToggle<CR> " requires ctags
nnoremap <leader>tu :UndotreeToggle<CR>
nnoremap <leader>ts :SyntasticToggle<CR>
nnoremap <leader>tf :CtrlP<CR>

" function call binding, requires functions defined at top of this file
nnoremap <leader>tc :call ToggleCursorCross()<CR>
nnoremap <leader>th :call ToggleHighlight()<CR>
nnoremap <leader>td :call DiffWithSaved()<CR>
