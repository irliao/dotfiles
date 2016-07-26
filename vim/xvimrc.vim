set ignorecase
set smartcase
set incsearch
set hlsearch
set number
set laststatus=2

nmap s i<CR><ESC>==
nmap S d$O<ESC>p==

map ,aw viw:xccmd findSelectedTextInWorkspace<CR>
map ,aa :xccmd findInWorkpace<CR>
map ,tw :xccmd jumpToDefinition<CR>
map ,tt :xccmd jumpToDefinition<CR>

map ,mm :xccmd saveAllEditorDocuments<CR>:xcmenucmd Run<CR>
map ,mt :xccmd saveAllEditorDocuments<CR>:xcmenucmd Test<CR>