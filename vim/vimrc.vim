" Vim Configs
set nocompatible " vi improved, required

" WARN: Order matters
source ~/.vim/function.vim
source ~/.vim/plugin.vim
source ~/.vim/setting.vim
source ~/.vim/scheme.vim

" Cursor at position of last saved line when opening file
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" WARN: remove any [filetype off, filetype plugin indent on, syntax on], already included by vim-plug

" SuperTab settings
let g:SuperTabDefaultCompletionType = "<c-n>" " <tab> completion going -down- list


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
" WARN: uncomment two lines below to auto lint on save
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

" Extra white spaces display
hi ExtraWhitespace guibg=#CCCCCC
hi ExtraWhitespace ctermbg=161
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

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
" let g:startify_custom_footer = map(split(footer_prompt), 'repeat(" ", 3) . v:val')

" Vim-Galore suggested settings
" toggle cursorline whenc changing modes
autocmd WinEnter    * set cursorline
autocmd WinLeave    * set nocursorline
autocmd InsertEnter * set nocursorline
autocmd InsertLeave * set cursorline
" swap lines with above or below
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>
" quickly add empty lines, n[<Space> adds n lines
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" Vim-Signature settings
" display Signature even if there is no marks
" sign define Dummy
" autocmd VimEnter * bufdo execute 'sign place 21358 line=1 name=Dummy buffer=' . bufnr('%')
" autocmd BufNew   * execute 'sign place 21358 line=1 name=Dummy buffer=' . bufnr('%')

" Key bindings
let mapleader = ","
set mouse+=a " enable mouse mode (scrolling, selection, etc)
if &term =~ '^screen'
  if has('mouse_sgr')
    set ttymouse=sgr
  else
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
  endif
endif
" set timeoutlen=50 " WARN: DO NOT enable, enabling this will make <leader> maps unusable
" set timeout timeoutlen=1000 ttimeoutlen=100 " TODO: verify this fixes slow O inserts
" WARN: Use H (high), M (middle), or L (low) to jump to screen positions to shorten the distance

" Incsearch settings
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

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

" disable arrow keys in Navigation mode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" add empty line above or below the current line
" map <Enter> o<Esc>
" map <S-Enter> O<Esc>

" ; -> :. less shift
" nnoremap ; :
" make :W save too
" command! W write " TODO: figure out what this does

" Visual/Select mode binding
vmap / gc " comment out visually selected lines
" TODO: refactor '<leader>/' to toggle instead of unhighlight search results
nnoremap <leader>/ :nohlsearch<Bar>:echo<CR> " unhighlight search results
nnoremap <leader>R :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l> " redraw screen

" scroll buffer vertically by visual line
nnoremap j gj
nnoremap k gk

" move current line in normal mode TODO: make sure this does not conflict
nnoremap > >>
nnoremap < <<

" move blocks of text in visual mode
vnoremap < <gv
vnoremap > >gv

" Select all text
map <Space>a ggVG
" Indent everything
noremap <Space>I ggvG=
" Indent selection in visual mode
vnoremap <Space>i =
" Indent the current line
noremap <Space>i v=

" highlight last inserted (or all text if none) text
" mapped to 'gV' because 'gv' highlights last visual selection
nnoremap gV `[v`]

"map kj sequence to escape
inoremap kj <ESC>

" TODO: figure out what this does
" move screenline instead of bufferline
" noremap <C-J> gj
" noremap <C-K> gk

" TODO: verify this actually fixes pasting issue from yanking trailing character
" don't copy the contents of an overwritten selection.
vnoremap p "_dP

" 1 to beginning of line, 0 to end of line in Normal mode
map 0 ^
map 1 $

" Normal mode only:
" Copy until the end of the line
nnoremap Y y$
" Change current word - kill
nnoremap X ciw
" Change in double quotes
nnoremap I ci"
" Join lines
nnoremap <Space>J J
" Enter the command-line mode
nnoremap <leader>; :

" Ctrl-A to beginning of line, Ctrl-E to end of line
nnoremap <C-a> ^
nnoremap <C-e> $

" faster block jumping when pressing right/left Shift key overwritten by Karabiner
" nnoremap ) }
" nnoremap ( {
"nnoremap J }
" nnoremap K {

" utility binding, WARN: some mappings CANNOT have trailing comments
noremap U :redo<CR> " revert last undo
nnoremap <leader>% :%y+<CR> " copy all texts in buffer to system clipboard
nnoremap <leader>` :marks<CR>
nnoremap <leader>" :registers<CR>
nnoremap <leader>r :so $MYVIMRC<CR>

" pane/window navigation binding
nnoremap <leader>j <C-d> " scroll down:delmarks! half a page
nnoremap <leader>k <C-u> " scroll up half a page
nnoremap <leader>' <C-w><C-w><CR> " go to previous pane
nnoremap <leader>a <C-w><C-w><CR> " go to previous pane like Tmux
nnoremap <leader>\ :tabn<CR> " go to next buffer/tab
nnoremap <leader><Tab> :tabn<CR> " go to next buffer/tab like Tmux
nnoremap <leader>[ :tabp<CR> " go to next buffer/tab
nnoremap <leader>] :tabn<CR> " go to next buffer/tab

" tab/buffer binding
" nnoremap <leader><BS> :ls<CR> " TODO: broken
nnoremap <leader>b :buffers<CR>
nnoremap <leader>n :vnew<CR>
nnoremap <leader>s :vsplit<Space>
nnoremap <leader>w :hide<CR> " close current pane like Tmux
nnoremap <leader>S :split<Space>
nnoremap <leader>N :tabnew<CR>
nnoremap <leader>e :tabedit<Space>
nnoremap <leader>f :tabfind<Space>
" nnoremap <leader>m :tabmove<Space> " TODO: figure out how to use
nnoremap <leader>d :cd %:p:h<cr>:pwd<cr>
nnoremap <leader>o :tabonly<CR> " close all tabs except the current one
nnoremap <leader>p :tabedit <c-r>=expand("%:p:h")<CR>/
nnoremap <leader>W :tabdo :q<CR> " close all open tabs
nnoremap <leader>ta :tab ball <CR> " reopen all closed tabs/buffers

" Vim-Tmux-navigator keys to go from Vim to Tmux
" WARN: should match the bindings defined in tmux.conf
" let g:tmux_navigator_no_mappings = 1 " 2 - write all buffers before going from Vim to Tmux
" nnoremap <silent> {Left-Mapping} :TmuxNavigateLeft<cr>
" nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
" nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
" nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
" nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

" toggle plugin binding
nnoremap <leader><Space> :NERDTreeToggle<CR> " similar to Tmux side-tree
" WARN: make sure 't' is not binded
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

" matching params for different languages
autocmd FileType xml,html set mps+=<:>
autocmd FileType c,cpp,java set mps+==:;

" syntastic binding
nnoremap <leader>sp :lprevious<CR> " go to previous error from Syntastic check, use ':lnext" for next error
" nnoremap <leader>\| :lclose<CR> " close error panel from Syntastic check TODO: check if this can be done using SyntasticToggle instead

" js-beautify plugin bindings, uses .editorconfig file
autocmd FileType javascript noremap <buffer> <leader>tb :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <leader>tb :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer> <leader>tb :call JsxBeautify()<cr>
autocmd FileType html noremap <buffer> <leader>tb :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <leader>tb :call CSSBeautify()<cr>

" Make Vim recognize XTerm escape sequences for Page and Arrow
" keys combined with modifiers such as Shift, Control, and Alt.
" See http://www.reddit.com/r/vim/comments/1a29vk/_/c8tze8p
" if &term =~ '^screen'
"   " Page keys http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/FAQ
"   execute "set t_kP=\e[5;*~"
"   execute "set t_kN=\e[6;*~"

"   " Arrow keys http://unix.stackexchange.com/a/34723
"   execute "set <xUp>=\e[1;*A"
"   execute "set <xDown>=\e[1;*B"
"   execute "set <xRight>=\e[1;*C"
"   execute "set <xLeft>=\e[1;*D"
" endif

" TODO: enable only when using iTerm
" change cursor for Tmux in iTerm
" if exists('$TMUX')
"     let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"     let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
" else
"     let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"     let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" endif

" iTerm2 specificsettings
" cursor shapes for different mode
" let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" let &t_SR = "\<Esc>]50;CursorShape=2\x7"
" let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" cursor shapes for different mode running in Tmux
" let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
" let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
" let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
"
" Unused settings

" " NerdTree settings
" " close Vim if only window left open is NerdTree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" " auto open if vim starts up with no file specified (e.g. vim, not vim .)
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif


" TODO: broken...
" highlight the current line when you do a search, and remove the highlight when the cursor moves.
" hi CursorLine cterm=reverse
" com! LINE :exe 'se cul'
" au CursorMoved * :se nocul
" au CursorMovedI * :se nocul
" noremap n nzz:LINE<CR>
" noremap N Nzz:LINE<CR>
" noremap * *zz:LINE<CR>
" noremap # #zz:LINE<CR>

