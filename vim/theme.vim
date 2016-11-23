" Color scheme for Vim and Gvim

set background=dark
" Color theme settings
if has("gui_running")
  " Molokai Theme
  colorscheme badwolf
  " let g:molokai_original = 1 " use original monokai background color
  " let g:rehash256 = 1 " attempts to bring the 256 color version as close as possible to the the default (dark) GUI version
  " set guifont=Source\ Code\ Pro\ for\ Powerline:h13
  set guifont=Hack\ Regular:h13
  " TODO: configure highlights like below, but replace cterm with gui, ex: ctermfg -> guifg
else
  colorscheme hybrid_reverse
  let g:enable_bold_font = 1

  " colorscheme molokai
  " hi Normal ctermbg=none
  " hi NonText ctermbg=none
  " hi LineNr ctermbg=none
  " let g:molokai_original = 1 " use original monokai background color
  " let g:rehash256 = 1 " attempts to bring the 256 color version as close as possible to the the default (dark) GUI version

  " colorscheme monokai
  " hi Normal ctermbg=none
  " hi NonText ctermbg=none
  " hi LineNr ctermbg=none
  " set t_Co=256 " iTerm2 256 color mode for Airline highlight

  " colorscheme seti
  " let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
  " hi Normal ctermbg=none " ctermbg=none is needed to fix bad line background coloring
  " hi Visual ctermbg=Red ctermfg=Black cterm=none
  " hi Search ctermbg=Red ctermfg=Black cterm=none
  " TODO: configure highlight for WildMenu
  " TODO: configure highlight for MatchParen
  " TODO: more customization at http://andrewradev.com/2011/08/06/making-vim-pretty-with-custom-colors/

  " colorscheme badwolf
  " let g:badwolf_darkgutter = 0
  " let g:badwolf_tabline = 1

  " colorscheme autumn
  " hi Normal ctermbg=none " ctermbg=none is needed to fix bad line background coloring
  " hi Visual ctermbg=Red ctermfg=Black cterm=none
  " hi Search ctermbg=Red ctermfg=Black cterm=none

  " TODO: change highlight color for menu selection, e.g. :Plug -> Tab selection
  " colorscheme happy_hacking " based on autum theme
  " set termguicolors
  " set t_ut=

endif
