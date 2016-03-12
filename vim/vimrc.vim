" Vim Configs

set nocompatible " vi improved, required

" Automatic installation for Vim-Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Autoreload vimrc on safe
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

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

function! DiffWithSaved ()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call DiffWithSaved()

" YouCompleteMe
function! BuildYCM(info)
    " info is a dictionary with 3 fields
    " - name:   name of the plugin
    " - status: 'installed', 'updated', or 'unchanged'
    " - force:  set on PlugInstall! or PlugUpdate!
    if a:info.status == 'installed' || a:info.force
        !./install.py --clang-completer --tern-completer
    endif
endfunction

" Vim-Plugin
call plug#begin('~/.vim/bundle')
Plug 'elzr/vim-json' " highlight key:value for JSON
Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file, buffer, mru, tag, etc finder
Plug 'scrooloose/syntastic' " syntax checker
Plug 'vim-airline/vim-airline' " Lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline-themes' " themes for Airline
Plug 'tpope/vim-fugitive' " Git wrapper, install vim-git if Vim version < 7.2
Plug 'tpope/vim-commentary' " Comment/Uncomment selected lines with: gc
Plug 'terryma/vim-multiple-cursors' " Sublime Text style multiple selections
Plug 'christoomey/vim-tmux-navigator' " Vim/Tmux split navigation... TODO: refactor ~/.tmux.conf to remove this Plug
Plug 'airblade/vim-gitgutter' " show Git diff in gutter
Plug 'mbbill/undotree' " show history of undos in side panel
Plug 'majutsushi/tagbar' " displays tags in a window, ordered by scope
Plug 'rking/ag.vim' " use AG in Vim faster
Plug 'tpope/vim-surround' " change surrounding char/tag
Plug 'nathanaelkane/vim-indent-guides' " visualize identations
Plug 'mhinz/vim-startify' " provides a start screen
Plug 'morhetz/gruvbox' " color theme for Vim shell
Plug 'tomasr/molokai' " color theme for Vim gui
Plug 'hukl/Smyck-Color-Scheme' " color theme for contrast
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " show file system tree
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM'), 'for': ['cpp', 'js'] }
autocmd! User YouCompleteMe if !has('vim_starting') | call youcompleteme#Enable() | endif
call plug#end()
" NOTE: remove any [filetype off, filetype plugin indent on, syntax on], already included by vim-plug

" Default settings
set encoding=utf-8
set nu " line numbering
set autoindent " autoindent
set noerrorbells " disable error bells
set modeline " ???!!! something about setting vars specific to files
set noshowmode " hide the default mode text (e.g. -- INSERT -- below the statusline)
set nowrap " display long lines as is
set ignorecase " ignoring cases for search
set backspace=indent,eol,start " backspace over everything
set fileformats=unix,dos,mac " open files from mac/dos
set exrc " load .exrc (rc for vi) if present
set nojoinspaces " no extra spaces after sentences
set ruler " show position in line
set cursorline " use '_' character for cursor
set showmatch " highlight matching code such as {},(),[]
set incsearch " search while typing before Return
set hlsearch " highlight search results 
set bs=2 " allow backspace character (CTRL-H or '<-'
set t_Co=256 " iTerm2 256 color mode for Airline highlight
set showcmd "show input of incomplete command, short 'set sc'
set laststatus=2 " always display the statusline in all windows
set showtabline=2 " always display the tabline, even if there is only one tab
set clipboard=unnamed " yanks go on clipboard instead 
set magic " for regular expression
set smartcase  " use case if any upper-case chars used
set visualbell " disable bell
let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1) " When going over 80 chars, will start highlighting red
setlocal textwidth=80 " used for text wrapping
set tabstop=4 " show existing tab with 4 spaces width
set shiftwidth=4 " when indenting with '>', use 4 spaces width
set expandtab " On pressing tab, insert 4 spaces
set splitright " all new splits open on right side
set wildmenu
set display+=lastline
set hidden " buffers to be hidden if you've modified a buffer

" Disable swap files from generating
set noswapfile " no more *.swp files during Vim edit
set nobackup
set nowb

" Scroll settings
set scrolloff=5 
set sidescrolloff=15
set sidescroll=1

" fix slow performance when editing small files
" set nocursorline
set nocursorcolumn
set norelativenumber
set foldmethod=manual " set foldmethod=marker
set synmaxcol=200
set lazyredraw " Don't redraw while executing macros (good performance config)
let loaded_matchparen=1 " avoid loading matchparen

" Ctrl-P settings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " Linux/MacOSX
let g:ctrlp_user_command = 'find %s -type f' " MacOSX/Linux
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 5
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

" The Silver Searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor " Use ag over grep
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""' " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_use_caching = 0 " ag is fast enough that CtrlP doesn't need to cache
endif

" Key bindings
" Disable Arrow keys to force train Vim navigation keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
" Escape key speed set in ~/.tmux.conf
let mapleader = "\<Space>"
xnoremap <  <gv " highlight visually selected when indent using <
xnoremap >  >gv " highlight visually selected when indent using < 
nnoremap <leader>` :marks<CR>
nnoremap <leader>" :regs<CR>
nnoremap <leader>a <C-w><C-w><CR> " go to previous pane within Vim
nnoremap <leader>w :bp <BAR> bd #<CR> " close current tab and focus previous
nnoremap <leader><Tab> :bnext<CR> " go to next buffer (visualized as tabs from Airline
nnoremap <leader>C :call ToggleCursorCross()<CR>
nnoremap <leader>d :call DiffWithSaved()<CR>
nnoremap <leader>i :IndentGuidesToggle<CR>
nnoremap <leader>/ :NERDTreeToggle<CR>
nnoremap <leader>? :TagbarToggle<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>p :CtrlP<CR>
nnoremap <leader>c :set cursorline!<CR>
nnoremap <leader>h :set hlsearch!<CR>
nnoremap <leader>d :DiffSaved<CR>
nnoremap <leader>r :so $MYVIMRC<CR>
nnoremap <leader>t :enew<CR>
" nnoremap <leader>N :tabnew<CR>
nnoremap <leader>e :e 
nnoremap <leader>s :vnew
nnoremap <leader>S :new
" nnoremap <leader>w :hide<CR> " close current window

" Vim-Airline
let g:airline#extensions#tabline#enabled = 1 " auto displays all buffers when there's only one tab open
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#enabled = 1 " enable the list of buffers
let g:airline#extensions#tabline#fnamemod = ':t' " show just the filename
set ambiwidth=double
set noshowmode " rid of the default mode indicator
" set laststatus=2 " always display Airline
" set timeoutlen=50 " NOTE: enabling this will make <leader> maps unusable

" Color theme settings
if has("gui_running")
  " Molokai Scheme
  colorscheme molokai
  set background=dark
  let g:molokai_original = 1 " use original monokai background color
  let g:rehash256 = 1 " attempts to bring the 256 color version as close as possible to the the default (dark) GUI version
  set guifont="Hack Regular:12"
else
  colorscheme smyck
  set background=dark 
  " Gruvbox Scheme
  " colorscheme gruvbox
  " set background=dark
  " let base16colorspace=256  " access colors present in 256 colorspace
  " let g:gruvbox_contrast_dark='medium' " _light, hard | medium | soft
endif

" Ident-Guides color settings
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

" Syntastic settings TODO: modify after reading the manual
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jshint']

" Cursor at position of last saved line when opening file
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" Vim-multiple-cursors TODO: understand this feature
let g:multi_cursor_start_key='<C-n>' " start with no word boundaries in Normal mode
let g:multi_cursor_start_word_key='g<C-n>' " start with default boundaries
let g:multi_cursor_quit_key='<C-c>'
nnoremap <C-c> :call multiple_cursors#quit()<CR>

" Show trailing spaces/tabs as special chaaracters TODO: map this feature
" set list listchars=eol:¬,tab:▸\
" set list listchars=tab:!·,trail:·
" set list listchars=tab:>-,trail:.,precedes:<,extends:>
" if &listchars ==# 'eol:$' set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+ endif

" EOF
