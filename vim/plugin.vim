" Plugins managed by Plug

" Automatic installation for Vim-Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Vim-Plug
call plug#begin('~/.vim/bundle')

" utility
Plug 'conradIrwin/vim-bracketed-paste' "  enables transparent pasting into vim. (i.e. no more :set paste!)
Plug 'scrooloose/syntastic' " syntax checker
Plug 'tpope/vim-commentary' " comment/uncomment selected lines with: gc
Plug 'mbbill/undotree' " show history of undos in side panel
Plug 'majutsushi/tagbar' " displays tags in a window, ordered by scope
Plug 'christoomey/vim-tmux-navigator' " Vim/Tmux unified navigation key TODO: remove
Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file, buffer, mru, tag, etc finder
Plug 'rking/ag.vim' " use AG in Vim faster
Plug 'junegunn/vim-easy-align' " alignment tool
Plug 'ervandew/supertab' " tab completion going down list
Plug 'haya14busa/incsearch.vim' " incrementally highlights all pattern
Plug 'tpope/vim-surround' " change surrounding (ex: parentheses, brackets, quotes, etc)
Plug 'tpope/vim-repeat' " epeating supported plugin maps with '.'
Plug 'sjl/gundo.vim' " visualize unndo tree
Plug 'tmux-plugins/vim-tmux' " editor helper for .tmux.conf files
Plug 'tmux-plugins/vim-tmux-focus-events' " improve autoread by automatically reading a file from disk if it was changed
Plug 'terryma/vim-multiple-cursors'
Plug 'sjl/vitality.vim' " better focus event from Vim in both Tmux and iTerm2
Plug 't9md/vim-choosewin'
Plug 'mileszs/ack.vim'

" visual
Plug 'mhinz/vim-startify' " fancy start screen
Plug 'vim-airline/vim-airline' " Lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline-themes' " themes for Airline
Plug 'tpope/vim-fugitive' " Git wrapper, install vim-git if Vim version < 7.2
Plug 'airblade/vim-gitgutter' " show Git diff in gutter
Plug 'kshenoy/vim-signature' " mark navigator
Plug 'ervandew/screen'

" language specific
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'maksimr/vim-jsbeautify', { 'for': 'javascript' } " formats JavaScript
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'editorconfig/editorconfig-vim' " uses ~/.editorconfig for vim-jsbeautify
Plug 'plasticboy/vim-markdown', { 'for': 'mkd' }
Plug 'elzr/vim-json', { 'for': 'json' } " highlight key:value for JSON
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'ryym/vim-riot'
Plug 'keith/tmux.vim'

" color scheme
Plug 'tomasr/molokai'
Plug 'w0ng/vim-hybrid'
Plug 'morhetz/gruvbox'
Plug 'hukl/smyck-color-scheme'
Plug 'chriskempson/base16-vim'
Plug 'sjl/badwolf'
Plug 'Lokaltog/vim-distinguished'
Plug 'sickill/vim-monokai'
" Plug 'crusoexia/vim-monokai' " refined vim-monokai
Plug 'trusktr/seti.vim'
Plug 'yorickpeterse/autumn.vim'
Plug 'YorickPeterse/happy_hacking.vim'

" autocompletion
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM'), 'for': ['cpp', 'js'] }
autocmd! User YouCompleteMe if !has('vim_starting') | call youcompleteme#Enable() | endif

" unused plugins
Plug 'scrooloose/nerdtree' " , { 'on': 'NERDTreeToggle' }
" Plug 'easymotion/vim-easymotion' " faster motions with jump to target

call plug#end()


