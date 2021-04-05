" Keyboard mappings sourced by ~/.vimrc

" Key bindings
let mapleader = ";"
" let maplocalleader = '\' " prefix for mappings that only apply to specific buffers

" seems to fix the issue of Cmd+V pasting extra character to Command line
" set timeoutlen=50 " WARN: DO NOT enable, enabling this will make <leader> maps unusable
set timeout timeoutlen=1000 ttimeoutlen=100

" leader + 'y' register copy and paste mappings.
noremap <leader>y :let @y=getreg('*')<CR>
noremap <leader>p "yp
noremap <leader>P "yP

" make Y behave like other capital letter mappings, may conflict with :register default bindings
" make Y yank from cursor position to end of line instead of default yank entire line
nnoremap Y y$

" Go to the starting position after visual modes
vnoremap <ESC> o<ESC>
" Escape from Select mode to Normal mode
snoremap <ESC> <C-c>

" prevent accidentally entering EX mode
nnoremap Q <Nop>

" navigation in command line
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" open :help split vertically, auto expands :H + <Space> to :vert h
cnoreabbrev H vert h

" change to directory of current file window
command! Cwd cd %:p:h
cnoreabbrev CD Cwd

" create 'tag' files for auto completeion (requires install from brew tap 'universal-ctags')
command! MakeTags !ctags -R .

" snippets
nnoremap ,java :-1read $HOME/.vim/snippets/skeleton.java<CR>2wi

" show all <leader> mappings
nnoremap <leader>? :map <leader><CR>

" NOTE: if run into issue again with / -> paste, try pressing Up then paste, if works remap fix to appropriate bindings
" comment out visually selected lines, same as typing 'gc' in Visual mode
" NOTE: binding must be 'vmap', adding 'nore' disables the plugin from commenting
vmap / <Plug>Commentary

" In Command mode (i.e. after pressing ':'), expand '%%' to the path of the current
" buffer. This allows you to easily open files from the same directory as the currently opened file.
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" wrapped lines are recognized by j/k
noremap j gj
noremap k gk

" move current line in normal mode
nnoremap > >>
nnoremap < <<

" move blocks of text in visual mode
vnoremap < <gv
vnoremap > >gv

" don't copy the contents of an overwritten selection.
vnoremap p "_dP

" 1 to beginning of line, 0 to end of line in Normal mode
" ^ and $ can be used in regex for start and end of the line, ex: :%s/^/# substitudes start of all lines with # character
nnoremap 0 ^
nnoremap 1 $

" Ctrl-A to beginning of line, Ctrl-E to end of line
nnoremap <C-a> ^
nnoremap <C-e> $

" Ctrl-A jump to beginning, Ctrl-E jump to end of the current line in the Insert mode
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$

" make :W save too
command! W write
" same as :w
nnoremap zz :w<CR>
" revert last undo
nnoremap U :redo<CR>

" edit ~/.vimrc
nnoremap <leader>, :vsplit $MYVIMRC<cr>
" reload vimrc and refresh UI
nnoremap <leader>. :so $MYVIMRC <bar> :so $MYVIMRC<CR>

" copy all texts in buffer to system clipboard
nnoremap <leader>% :%y+<CR>
nnoremap <silent> <leader>` :execute 'set showtabline=' . (&showtabline ==# 0 ? 2 : 0)<CR>
nnoremap <leader>' :marks<CR>
nnoremap <leader>" :registers<CR>
nnoremap <leader>m :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left> " edit register/macro (* if none passed in), use like: <leader>m or "q<leader>m

" redraw screen
nnoremap <leader>r :nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><c-l>

" TODO: enable after finding a different key to map to
" diff unsaved buffer against saved buffer
" nnoremap <leader>d :call DiffWithSaved()<CR> " diff current buffer aganst most recent save

" file searching
nnoremap <leader>f :Ack!<SPACE>
nnoremap <leader><Space> :CtrlP<CR>

" buffer navigation
nnoremap <leader>e :edit<Space>
nnoremap <leader>n :enew<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>1 :BuffergatorOpen<CR> " show list of buffers in Buffergator
nnoremap <leader>b :BuffergatorMruCyclePrev<CR>
nnoremap <leader>B :BuffergatorMruCycleNext<CR>
nnoremap <leader>w :bd<CR> " close current buffer only
nnoremap <leader>W :Sayonara<CR>

" pane handling
nnoremap <leader>{ <C-b> " scroll up full page
nnoremap <leader>} <C-f> " scroll down full page
nnoremap <leader>[ <C-w>p<CR> " focus previous split
nnoremap <leader>] <C-w>w<CR> " focus next split
nnoremap <leader>d :vnew<CR> " split vertically
nnoremap <leader>D :new<CR> " split horizontally
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>T <C-w>T " break out current window buffer into a new tabview
nnoremap <leader>q :ccl<CR> " close quickfix window

" tab navigation
nnoremap <leader><bar> :BuffergatorTabsOpen<CR> " show list of tabs in Buffergator
nnoremap <leader><Tab> :tabprevious<CR>
nnoremap <leader><S-Tab> :tabnext<CR>
nnoremap <leader>0 :<C-u>tabfirst<CR>
nnoremap <leader>$ :<C-u>tablast<CR>

