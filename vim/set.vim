" Settings usable by Vim without needing plugins

" Encoding and end of line.
" Default file encoding for new files.
setglobal fenc=utf-8
" Detect file encoding when opening a file and try to choose from the following
" encoding list (to check what file encoding was selected run ":set fenc").
set fencs=ucs-bom,utf-8
" Internal encoding used by Vim buffers, help and commands.
set enc=utf-8
" Terminal encoding used for input and terminal display.
" set tenc=utf-8

" Vim custom settings
set encoding=utf-8
set modeline " ???!!! something about setting vars specific to files
" set backspace=indent,eol,start " custom configure backspace
set backspace=eol,start,indent " backspacing over line breaks and start of insert
set linespace=1
set fileformats=unix,dos,mac " open files from mac/dos
set exrc " load .exrc (rc for vi) if present
set tags+=.tags
set shortmess=atI
set complete-=i
set complete-=t
set completeopt-=preview
set autochdir " automatically set current directory to directory of last opened file
set clipboard=unnamed " yanks to OSX clipboard instead TODO: requires Brew installed Vim
" set paste " WARN: no used due to vim-bracketed-paste fixing paste
" set nohidden " disable unsaved buffers
set hidden " hide buffers
set nostartofline " don't move the cursor to the start of line
set ttyfast " makes some actions smoother (?)
set shortmess=I " no startup messages

" auto-completion settings
set wildmenu " visual autocomplete for Vim command menu
set wildignore+=*.o,*.obj,*.pyc,*.aux,*.bbl,*.blg,.git,.svn,.hg
" set wildmode=list:longest,full " autocompletion menu layout

" text wrap
" let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1) " highlight text past 80 chars " TODO: make a toggle function
set nojoinspaces " suppress inserting two spaces between sentences
set nowrap " display long lines as is
" set textwidth=0 " disable auto newline during Insert mode
" set whichwrap+=<,>,h,l " scrolling past end of line begins at start of next line
" set linebreak " wrap lines at convenient points
set textwidth=0 " original setting: set textwidth=110
let &wrapmargin= &textwidth
set formatoptions=croql

" visual
set modelines=0
set number " line numbering
set ruler " show position in line
set cursorline " use '_' character for cursor
set fillchars+=stl:\ ,stlnc:\ " disable statusline fillchars
set noshowmode " hide Vim mode indicator
set noshowmode " hide Vim mode indicator
" set laststatus=2 " always display statusline (e.g. Airline), default displays Airline only if there is a split
" set colorcolumn=+1 " highlight max textwidth column (current is 80)

" show line break characters
" set list
" set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮

" set ch=0 " statusline height
" set statusline=%-30.50(%n\ %f\ %m%h%r%w%)%l/%L\ (%p%%),\ %c\ %<%=%(\(%{bufnr(\"#\")}\ %{bufname(\"#\")})%)
" set showtabline=2 " always display the tabline, even if there is only one tab
set showcmd " show last command in the bottom right
set splitbelow " new window opens below current one
set splitright " new window opens to the right of current one
set ambiwidth=single

" disable visual alert for errors
set noerrorbells " disable error bell
set novisualbell " disable visual bell
set t_vb= " disable visual flash

" search
set showmatch " highlight matching code such as {},(),[]
set mat=2 " show matching brackets for 2 tenths of a second to blink
set incsearch " search while typing before Return
set hlsearch " highlight search results
set ignorecase " ignoring cases for search
set smartcase  " searches with case if any upper-case chars used
set magic " for regular expression
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$' " highlight VCS conflict markers

" identation
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2 " number of spaces in tab when editing
set tabstop=2
set expandtab " tabs are spaces

" lines visible when scrolling past window
set scrolloff=5 " lines from top and bottom
set sidescrolloff=5 " lines on the left
set sidescroll=3 " lines from when scrolled off the window

" optimizations (when editing small files)
set nocursorcolumn
set norelativenumber
set foldmethod=manual " set foldmethod=marker
set synmaxcol=200
set lazyredraw " no redraw while executing macros custom Airline
let loaded_matchparen=1 " avoid loading matchparen
" set nocursorline " no '_' character for cursor

" swap files
set noswapfile " no more *.swp files during Vim edit
set nobackup
set nowb
" set noundofile " TODO: maybe re-enable swap file, backup, and undo file
" Ensure the temp dirs exist
" call system("mkdir -p ~/.vim/tmp/swap")
" call system("mkdir -p ~/.vim/tmp/backup")
" call system("mkdir -p ~/.vim/tmp/undo")
" Change where we store swap/undo files
" set dir=~/.vim/tmp/swap/
" set backupdir=~/.vim/tmp/backup/
" set undodir=~/.vim/tmp/undo/
