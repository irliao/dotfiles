" Keyboard mappings sourced by ~/.vimrc
" WARN: all mappings here should only need default Vim features and should not depend on any external plugins
" TODO: cleanup file

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

" disable arrow keys in Navigation mode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Enter the command-line mode
nnoremap <leader>; :

" swap lines with above or below
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>
" quickly add empty lines, n[<Space> adds n lines
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" Incsearch settings
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Visual/Select mode binding
vmap / gc " comment out visually selected lines
" TODO: refactor '<leader>h' to toggle instead of unhighlight search results
nnoremap <leader>h :nohlsearch<Bar>:echo<CR> " unhighlight search results
nnoremap <leader>R :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l> " redraw screen

" scroll buffer vertically by visual line
nnoremap j gj
nnoremap k gk

" move current line in normal mode
nnoremap > >>
nnoremap < <<

" move blocks of text in visual mode
vnoremap < <gv
vnoremap > >gv

" Select all text
map <Space>a ggVG

" highlight last inserted (or all text if none) text
" mapped to 'gV' because 'gv' highlights last visual selection
nnoremap gV `[v`]

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
" Change in double quotes, TODO: make sure this does not conflict
nnoremap I ci"
" Join the line below with current line
nnoremap <Space>J J

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
" nnoremap <leader>a <C-w><C-w><CR> " go to previous pane like Tmux
" nnoremap <leader>\ :tabn<CR> " go to next buffer/tab
nnoremap <leader>\ <C-w><C-w><CR> " go to previous pane like Tmux
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

" add empty line above or below the current line
" map <Enter> o<Esc>
" map <S-Enter> O<Esc>

" ; -> :. less shift
" nnoremap ; :
" make :W save too
" command! W write " TODO: figure out what this does

