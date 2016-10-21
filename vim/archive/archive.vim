" Archived (unused, obsolete, broken) Vim settings

" Vim-Tmux-navigator keys to go from Vim to Tmux
" WARN: should match the bindings defined in tmux.conf
" let g:tmux_navigator_no_mappings = 1 " 2 - write all buffers before going from Vim to Tmux
" nnoremap <silent> {Left-Mapping} :TmuxNavigateLeft<cr>
" nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
" nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
" nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
" nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

" JsBeautify plugin bindings, uses .editorconfig file
" autocmd FileType javascript noremap <buffer> <leader>tb :call JsBeautify()<cr>
" autocmd FileType json noremap <buffer> <leader>tb :call JsonBeautify()<cr>
" autocmd FileType jsx noremap <buffer> <leader>tb :call JsxBeautify()<cr>
" autocmd FileType html noremap <buffer> <leader>tb :call HtmlBeautify()<cr>
" autocmd FileType css noremap <buffer> <leader>tb :call CSSBeautify()<cr>

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

