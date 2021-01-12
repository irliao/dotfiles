" set gdefault
set number
" set relativenumber
set history
set hlsearch
" set incsearch
set ignorecase smartcase
set showmode
set scrolloff=5
set sidescrolloff=5
set sidescroll=3
set visualbell " se visual bell instead of beeping
set wrapscan " searches wrap around the end of the file
set clipboard=unnamed " yanks to OSX clipboard instead TODO: requires Brew installed Vim

" Plugins
set surround " enable vim-surround like plugin
set vim-surround " commands: ys, cs, ds, S

nnoremap <C-.> :source ~/.ideavimrc<CR>

nnoremap <Esc><Esc> :nohlsearch<cr>

" 1 to beginning of line, 0 to end of line in Normal mode
" ^ and $ can be used in regex for start and end of the line, ex: :%s/^/# substitudes start of all lines with # character
" map 0 ^
" map 1 $
nnoremap 0 ^
" nnoremap 1 $ " TODO: not working
inoremap <C-a> <Esc>^i
inoremap <C-e> <Esc><S-a>
nnoremap <C-a> ^
nnoremap <C-e> $

" scroll buffer vertically by visual line
nnoremap j gj
nnoremap k gk

" redo last undo
noremap U :redo<CR>

" comment out visually selected lines
vmap / gc

" Scroll screen with the cursor
noremap <C-j> gj<C-e>
noremap <C-k> gk<C-y>
nnoremap <Up> <C-y>
nnoremap <Down> <C-e>

" Moving blocks of text in visual mode
nnoremap < <<
nnoremap > >>

" move blocks of text in visual mode
vnoremap < <gv
vnoremap > >gv

" don't copy the contents of an overwritten selection.
vnoremap p "_dP

" Copy until the end of the line
noremap Y y$
nnoremap Q @q

" :actionlist - list all available actions in Intellij
map \r :action ReformatCode<CR>
map <C-q> :action Stop<CR>
map <C-d> :action Debug<CR>
map <C-r> :action Run<CR> " TODO: fix issue with sometimes inserting 'hlsearch' into current line
" TODO: add more debug actions (ex. pause, skipover)

" window split
nnoremap <C-s> <C-w>v
nnoremap <C-S-s> <C-w>s

" window navigation (NOTE: Ctrl + HJKL is mapped to Arrows in Karabiner-ELement)
nnoremap <Left> <C-w>w
nnoremap <Right> <C-w><C-w>

" tab navigation
nnoremap <C-Tab> gT
nnoremap <C-S-Tab> gt
nnoremap <C-S-t> :action ReopenClosedTab<CR>

" file navigation
nnoremap <C-p> :action GotoFile<CR>

" TODO: check if leader key is even allowed in ideavim
" let mapleader = ';'
" nnoremap <leader>s :action SPlit Vertically<CR>

nnoremap ]e :action GotoNextError<CR>
nnoremap [e :action GotoPreviousError<CR>

" All available settings for ideavim
" 'clipboard'      'cb'    clipboard options
" 'digraph'        'dg'    enable the entering of digraphs in Insert mode
" 'gdefault'       'gd'    the ":substitute" flag 'g' is default on
" 'history'        'hi'    number of command-lines that are remembered
" 'hlsearch'       'hls'   highlight matches with last search pattern
" 'ignorecase'     'ic'    ignore case in search patterns
" 'incsearch'      'is'    show where search pattern typed so far matches
" 'matchpairs'     'mps'   pairs of characters that "%" can match
" 'nrformats'      'nf'    number formats recognized for CTRL-A command
" 'number'         'nu'    print the line number in front of each line
" 'relativenumber' 'rnu'   show the line number relative to the line with
"                          the cursor
" 'scroll'         'scr'   lines to scroll with CTRL-U and CTRL-D
" 'scrolljump'     'sj'    minimum number of lines to scroll
" 'scrolloff'      'so'    minimum nr. of lines above and below cursor
" 'selection'      'sel'   what type of selection to use
" 'showmode'       'smd'   message on status line to show current mode
" 'sidescroll'     'ss'    minimum number of columns to scroll horizontal
" 'sidescrolloff'  'siso'  min. nr. of columns to left and right of cursor
" 'smartcase'      'scs'   no ignore case when pattern has uppercase
" 'timeout'        'to'    use timeout for mapped key sequences
" 'timeoutlen'     'tm'    time that is waited for a mapped key sequence
" 'undolevels'     'ul'    maximum number of changes that can be undone
" 'viminfo'        'vi'    information to remember after restart
" 'visualbell'     'vb'    use visual bell instead of beeping
" 'wrapscan'       'ws'    searches wrap around the end of the file
