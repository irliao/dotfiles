" Plugins managed by Plug

" Should be same leader as one defined in map.vim, declared here to be used by user defined plugin mappings
let mapleader = ";"

" Automatic installation for Vim-Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Vim-Plug
call plug#begin('~/.vim/bundle')

" utility
Plug 'mileszs/ack.vim' " use Ag in Vim
Plug 'jeetsukumaran/vim-buffergator' " show lists of buffers with mru support
  " Buffergator to help manage buffers
  let g:buffergator_viewport_split_policy = 'R' " display at bottom of the window
  let g:buffergator_suppress_keymaps = 1 " use own keymappings
  let g:buffergator_autoexpand_on_split = 0
  "let g:buffergator_mru_cycle_loop = 1 " looper
Plug 'conradIrwin/vim-bracketed-paste' "  enables transparent pasting into vim. (i.e. no more :set paste!)
Plug 'scrooloose/syntastic'
  " Syntastic settings
  " set statusline+=%#warningmsg#
  " set statusline+=%{SyntasticStatuslineFlag()}
  " set statusline+=%*
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  " let g:syntastic_check_on_open = 1
  " let g:syntastic_check_on_wq = 0
  let g:syntastic_mode_map = {
      \ 'mode': 'passive',
      \ 'active_filetypes': [],
      \ 'passive_filetypes': []
  \}
  let g:syntastic_bash_checkers=['shellcheck']
  let g:syntastic_javascript_checkers = ['standard']
  let g:syntastic_javascript_standard_exec = 'semistandard'
  " autocmd bufwritepost *.js silent !standard --fix % " auto format on save
  " syntastic binding
  " NOTE: uncomment two lines below to auto lint on save
  " autocmd bufwritepost *.js silent !semistandard % --fix
  " set autoread
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " install latest binary if missing
Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file, buffer, mru, tag, etc finder
Plug 'tacahiroy/ctrlp-funky' " uses Ctrl-P to show list of functions in current buffer to jump to
Plug 'junegunn/vim-easy-align' " alignment tool
Plug 'haya14busa/incsearch.vim' " incrementally highlights all pattern
Plug 'tpope/vim-commentary' " comment out visually selected block with '/' in Visual mode
Plug 'tpope/vim-surround' " move in Mormal mode with surrounding objects as operator (ex: parentheses, brackets, quotes, etc)
Plug 'tpope/vim-repeat' " repeat supported plugin maps with '.'
Plug 'sjl/vitality.vim' " better focus event from Vim in both Tmux and iTerm2
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-endwise' " ends certain structure automatically (ex: in Lua, will auto insert 'end' for keywords like 'if' or 'function'
Plug 'romainl/vim-cool' " auto turn off search result highlights upon navigation
Plug 'sjl/gundo.vim' " visualize undo tree

" TODO: replace with https://github.com/mg979/vim-visual-multi
Plug 'terryma/vim-multiple-cursors'
  " multiple cursors plugin, NOTE: plugin only supports mapping to someMod + someKey (ex. <C-n> or <M-n>)
  let g:multi_cursor_use_default_mapping=0
  " requires pressing start_key to enter multicursor mode first, then press next_key to start marking lines
  " let g:multi_cursor_start_key='<C-m>' " map start key separately from next key
  " let g:multi_cursor_start_word_key='g<C-n>' " avoid word boundaries in Normal mode, should be g + start_key
  let g:multi_cursor_next_key='<C-n>'
  let g:multi_cursor_prev_key='<C-p>'
  let g:multi_cursor_skip_key='<C-x>'
  let g:multi_cursor_quit_key='<Esc>' " NOTE: make sure to always have quit_key mapped, otherwise issue with quitting
  " default highlighting (see help :highlight and help :highlight-link)
  " highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
  " highlight link multiple_cursors_visual Visual

"window management
Plug 'mhinz/vim-sayonara' " closes window appropriately based on current buffer/tab/split
Plug 't9md/vim-choosewin' " navigate window/split interactively
  let g:choosewin_overlay_enable = 1
  nnoremap <leader>g :ChooseWin<CR>

" visual
Plug 'kshenoy/vim-signature' " mark navigator
Plug 'tpope/vim-fugitive' " Git wrapper, install vim-git if Vim version < 7.2
Plug 'airblade/vim-gitgutter' " show Git diff in gutter
  set updatetime=100 " delay on when diff marks would appear, default 4000 (4 secs)
  let g:gitgutter_map_keys = 0 " disables GitGutter mappings to avoid delay with <leader>h
  let g:gitgutter_diff_args = '-w' " ignore whitespace
  cnoreabbrev GU GitGutterAll

" browser
Plug 'tyru/open-browser.vim' " open URI with browser
  " If it looks like URI, Open URI under cursor. Otherwise, Search word under cursor.
  nmap <leader>b <Plug>(openbrowser-smart-search)
  " If it looks like URI, Open selected URI. Otherwise, Search selected word.
  vmap <leader>b <Plug>(openbrowser-smart-search)
Plug 'previm/previm' " preview Markdown in browser, supports mermaid code block in Markdown files (util to generate diagrams like sequence or flowchart using code)
  " let g:previm_open_cmd = 'open -a Safari' " comment out if want to integrate and use open-browser vim plugin
  augroup PrevimSettings
      autocmd!
      autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
  augroup END

" language syntax
" Plug 'sheerun/vim-polyglot' " bundle of plugins for all the popular languages TODO: fix this breaking MarkDown file displays
Plug 'darfink/vim-plist' " display plist as xml/json (not included in vim-polyglot)
" let g:plist_display_format = 'xml' " NOTE: values: json|xml, setting it to one will display ALL other in specified format (original format is preserved when saving)
let g:plist_json_filetype = 'javascript' " change the filetype used for property lists in json format

Plug 'Yggdroot/indentLine' " show indent characters
  let g:indentLine_char = '┊'
  autocmd Filetype json :IndentLinesDisable " disabled plugin for json to prevent concealing of double and single qutes
  autocmd Filetype markdown :IndentLinesDisable " disabled plugin for markdown to prevent concealing of astericks when bolding lines

" language tools
Plug 'maksimr/vim-jsbeautify' " automatic formats JS files
Plug 'editorconfig/editorconfig-vim' " uses ~/.editorconfig for vim-jsbeautify

" tab completion
Plug 'ervandew/supertab'
  let g:SuperTabDefaultCompletionType = "<c-n>" " uses completion from ^N, which should be default from Vim
  let g:SuperTabMappingForward  = "<tab>"
  let g:SuperTabMappingBackward = "<s-tab>"
  function! SuperTab(m)
    return s:super_duper_tab(a:m == 'n' ? "\<c-n>" : "\<c-p>", a:m == 'n' ? "\<tab>" : "\<s-tab>")
  endfunction

" color scheme
Plug 'jacoborus/tender.vim' " 24bit colorscheme, resembles base16, light colors and less strains on the eyes
  let macvim_skip_colorscheme=1 " fixes issue where MacVim will not use tender as theme
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
" Plug 'chriskempson/base16-vim'
" Plug 'flazz/vim-colorschemes' " lots of color theme, may have conflict with same name themes from other plugins
"   cnoreabbrev CS colorscheme

" TODO: enable if Tmux is running
" Plug 'tmux-plugins/vim-tmux-focus-events' " improve autoread by automatically reading a file from disk if it was changed
" Plug 'benmills/vimux' " allow sending inputs to Tmux
" Plug 'keith/tmux.vim'
" Plug 'christoomey/vim-tmux-navigator' " Vim/Tmux unified navigation key
" Plug 'tmux-plugins/vim-tmux' " editor helper for .tmux.conf files
" Plug 'ervandew/screen' " split shell in Vim using screen or tmux

call plug#end()

