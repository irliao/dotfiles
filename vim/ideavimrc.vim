" set gdefault
set ignorecase
set norelativenumber

set clipboard=unnamed " yanks to OSX clipboard instead TODO: requires Brew installed Vim

" 1 to beginning of line, 0 to end of line in Normal mode
" ^ and $ can be used in regex for start and end of the line, ex: :%s/^/# substitudes start of all lines with # character
map 0 ^
map 1 $

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

" Home row beginning / end of line
noremap 0 ^
noremap 1 $

" Moving blocks of text in visual mode
nnoremap < <<
nnoremap > >>

" move blocks of text in visual mode
vnoremap < <gv
vnoremap > >gv

" TODO: verify this actually fixes pasting issue from yanking trailing character
" don't copy the contents of an overwritten selection.
vnoremap p "_dP

" Select all text
map <Space>a ggVG

" Copy until the end of the line
noremap Y y$

" Ctrl-A to beginning of line, Ctrl-E to end of line
nnoremap <C-a> ^
nnoremap <C-e> $
