" set gdefault
set ignorecase
set norelativenumber

set clipboard=unnamed " yanks to OSX clipboard instead TODO: requires Brew installed Vim

" scroll buffer vertically by visual line
nnoremap j gj
nnoremap k gk

" Scroll screen with the cursor
noremap <C-j> gj<C-e>
noremap <C-k> gk<C-y>

" Home row beginning / end of line
noremap 0 ^
noremap 1 $

" Moving blocks of text in visual mode
nnoremap < <<
nnoremap > >>

" Select all text
map <Space>a ggVG

" Copy until the end of the line
noremap Y y$
