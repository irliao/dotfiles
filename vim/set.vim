" Settings usable by Vim without needing plugins

" Encoding and end of line.
" Default file encoding for new files.
setglobal fenc=utf-8
" Detect file encoding when opening a file and try to choose from the following
" encoding list (to check what file encoding was selected run ":set fenc").
" set fencs=ucs-bom,utf8

" Internal encoding used by Vim buffers, help and commands.
set enc=utf-8
" Terminal encoding used for input and terminal display.
set tenc=utf-8
set ffs=unix,dos,mac " set fileformats type priority

" Vim custom settings
set encoding=utf-8
" set confirm " rather than just failing when quit without saving, prompt to save (yes or no) or cancel
set modeline " ???!!! something about setting vars specific to files TODO: research how this works exactly
set backspace=eol,start,indent " backspacing over line breaks and start of insert
set linespace=1
set exrc " load .exrc (rc for vi) if present
set tags+=.tags
set complete-=i
set complete-=t
set completeopt-=preview
set clipboard=unnamed " yanks to OSX clipboard instead
set clipboard+=unnamedplus
set hidden " a buffer becomes hidden when it is abandoned
set nostartofline " don't move the cursor to the start of line
set ttyfast " makes some actions smoother (?)
set shortmess=atI " no startup messages
set pastetoggle=<F9>
set esckeys " no delay on ESC
" set autochdir " auto set cwd to directory of last opened file
" set paste " WARN: not used due to vim-bracketed-paste fixing paste

" Keep the cursor on the same column
set nostartofline

" FOOBAR=~/<CTRL-><CTRL-F>
set isfname-==

if exists('&fixeol')
  set nofixeol
endif

" Remove _ from word characters - it will be treated as separator instead
set iskeyword-=_

" exclude files/directories from any search result, CtrlP and global
" set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " Linux/MacOSX
" set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

" auto-completion settings
set wildmenu " visual autocomplete for Vim command menu
set wildignore+=*.o,*.obj,*~,*.pyc,*.aux,*.bbl,*.blg,.git,.svn,.hg
set wildignore+=*~
set wildignore+=*DS_Store*
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=.idea/**
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/Library/**,*/.rbenv/**
" set wildmode=list:longest,full " autocompletion menu layout

" text wrap
set textwidth=0 " max width before auto inserting newline during Insert mode
" let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1) " highlight text past 80 chars " TODO: make a toggle function
set nojoinspaces " suppress inserting two spaces between sentences
set nowrap " display long lines as is
" set whichwrap+=<,>,h,l " scrolling past end of line begins at start of next line
" set whichwrap=h,l
" set linebreak " wrap lines at convenient points
let &wrapmargin=&textwidth
set formatoptions=croql
set whichwrap+=<,>,h,l,[,]

" absolute for current line, relative for all other lines
set number " line numbering
set relativenumber " relative number

" visual
" set browsedir=buffer " fix no effect
set modelines=0
set ruler " show position in line
set cursorline " use '_' character for cursor
set noshowmode " hide Vim mode indicator

" show line break characters
" set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
" set list listchars=tab:▸\ ,trail:.
" set list

" disables fillchars for statusline, :\ is used here specifically for spaces
" NOTE: there CANNOT be trailing comments after :\, even comments beginning with double-quotes
set fillchars+=stl:\ ,stlnc:\
set laststatus=2 " always display statusline (e.g. Airline), default displays Airline only if there is a split
" set ch=0 " statusline height
" set statusline=%-30.50(%n\ %f\ %m%h%r%w%)%l/%L\ (%p%%),\ %c\ %<%=%(\(%{bufnr(\"#\")}\ %{bufname(\"#\")})%)
set showtabline=1 " show tabline 0 - never, 1 - more than one tab, 2 - always
set showcmd " show last command in the bottom right
set splitbelow " new window opens below current one
set splitright " new window opens to the right of current one
set ambiwidth=single

" search
" set incsearch " search while typing before Return, overrode by pluginincsearch
set hlsearch " highlight search results
set ignorecase " ignoring cases for search
set smartcase  " searches with case if any upper-case chars used, only active if 'ignorecase' is set
set magic " for regular expression
set showmatch " highlight matching code such as {},(),[]
set mat=2 " show matching brackets for 2 tenths of a second to blink
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$' " highlight VCS conflict markers

" identation
set autoindent
set smartindent
set smarttab
set tabstop=2
set expandtab " tabs are spaces
set shiftwidth=2
set shiftround " indents to next multiple of &shiftwidth
set softtabstop=2 " number of spaces in tab when editing

" lines visible when scrolling past window
set scrolloff=5 " lines from top and bottom
set sidescrolloff=5 " lines on the left
set sidescroll=3 " lines from when scrolled off the window

" optimizations (when editing small files)
set nocursorcolumn
set foldmethod=manual " set foldmethod=marker
set synmaxcol=200 " only highlight first 200 columns
set lazyredraw " no redraw while executing macros custom Airline
let loaded_matchparen=1 " avoid loading matchparen
" set nocursorline " no '_' character for cursor

" store backup and undo files under ~/.vim/tmp/
if exists('*mkdir') && !isdirectory($HOME.'/.vim/tmp')
  call mkdir($HOME.'/.vim/tmp')
  call mkdir($HOME.'/.vim/tmp/backup')
  call mkdir($HOME.'/.vim/tmp/undo')
  call mkdir($HOME.'/.vim/tmp/info')
endif
set backup " latest back up file, persists even after successful :write
set backupdir   =$HOME/.vim/tmp/backup/
set backupext   =-vimbackup
set backupskip  =
set undofile
set undodir     =$HOME/.vim/tmp/undo/
set viminfo     ='100,n$HOME/.vim/tmp/info/viminfO

" no swap files
set noswapfile " no more *.swp files during Vim edit
" set directory   =$HOME/.vim/tmp/swap//
" set updatecount =100

" set noundofile " TODO: maybe re-enable swap file, backup, and undo file
" Ensure the temp dirs exist
" call system("mkdir -p ~/.vim/tmp/swap")
" call system("mkdir -p ~/.vim/tmp/backup")
" call system("mkdir -p ~/.vim/tmp/undo")
" Change where we store swap/undo files
" set dir=~/.vim/tmp/swap/
" set backupdir=~/.vim/tmp/backup/
" set undodir=~/.vim/tmp/undo/
