" Vim Configs
set nocompatible " vi improved, required
" WARN: remove any [filetype off, filetype plugin indent on, syntax on], already included by vim-plug

" WARN: source order matters
source ~/.vim/function.vim
source ~/.vim/plug.vim
source ~/.vim/theme.vim
source ~/.vim/set.vim
source ~/.vim/autocmd.vim
source ~/.vim/filetype.vim
source ~/.vim/map.vim
source ~/.vim/statusline.vim

" CtrlP settings
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_brief_prompt = 1 " 1 - <bs> on empty prompt exit CtrlP
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:10'
let g:ctrlp_switch_buffer = 0 " always open file in new buffer
let g:ctrlp_working_path_mode = 'ra' " r - nearest VCS (.git)ancestor, a - directory of the current file, unless it is a subdirectory of the cwd, -a/-c used as fallback when included with -r
let g:ctrlp_tabpage_position = 'ac' " open new tab -after -theCurrentTabPage
let g:ctrlp_root_markers = ['package.json', 'pom.xml', '.p4ignore'] " additional files to treat as SVC file, takes precedence over default (.git, .hg, etc)
let g:ctrlp_mruf_tilde_homedir = 0 " prepend every MRU file path with '$HOME/' instead of default '~/'
" let g:ctrlp_mruf_include = '\.py$\|\.rb$' " only remember some files
let g:ctrlp_mruf_exclude = '/tmp/.*\|/temp/.*' " MacOSX/Linux
" let g:ctrlp_mruf_exclude = '^C:\\dev\\tmp\\.*' " Windows
let g:ctrlp_mruf_relative = 0 " 1 - show only MRU files in cwd
" open files up to 2 vertical splits, open rest as hidden buffer
let g:ctrlp_open_multiple_files = '2vjr'
let g:ctrlp_line_prefix = '> '
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<cr>'],
  \ 'AcceptSelection("v")': ['<c-v>'],
  \ 'AcceptSelection("t")': ['<c-t>'],
	\ 'PrtHistory(1)':        ['<c-z>'],
	\ 'PrtHistory(-1)':       ['<c-x>'],
	\ 'ToggleFocus()':        ['<c-p>'],
	\ 'ToggleType(1)':        ['<c-g>'],
  \ 'ToggleMRURelative()':  ['<c-y>'],
	\ 'PrtExpandDir()':       ['<tab>'],
	\ 'MarkToOpen()':         ['<c-m>'],
	\ 'OpenMulti()':          ['<c-o>'],
  \ 'CreateNewFile()':      ['<c-n>'],
	\ 'ToggleRegex()':        ['<c-/>'],
  \ 'PrtClear()':           ['<c-u>'],
  \ 'PrtExit()':            ['<c-c>', '<esc>']
  \ }

" let g:ctrlp_extensions = ['line', 'buffer', 'quickfix', 'dir', 'rtscript', 'mixed' ]
" TODO: put all CtrlP settings in same file
" source ~/.vim/ctrlp.vim

" TODO: enable after fixing "trailing characters" issue
" alias every Ack commands with the Ag equivalent
" for command in ['Ack', 'AckAdd', 'AckFromSearch', 'LAck', 'LAckAdd', 'AckFile', 'AckHelp', 'LAckHelp', 'AckWindow', 'LAckWindow']
"   exe 'command ' . substitute(command, 'Ack', 'Ag', "") . ' ' . command
" endfor

" Ag setup for CtrlP, using Ack.vim mainly to port Ag in Vim
if executable('ag')
  " use Ag for :grep in Vim
  set grepprg=ag\ --nogroup\ --nocolor

  " use Ag for :Ack in Vim
  let g:ackprg = 'ag --nogroup --nocolor'
  " let g:ackprg = 'ag --nogroup --nocolor --column'
  " let g:ackprg = 'ag --vimgrep' " same effect as above but will print every single match as it's own line

  " substitute all Ag ex-commands to Ack
  cnoreabbrev ag Ack
  cnoreabbrev aG Ack
  cnoreabbrev Ag Ack
  cnoreabbrev AG Ack

  " disable jumping to first result automatically
  cnoreabbrev Ack Ack!
endif

" if s:grep ==# 'rg'
"   let g:ctrlp_user_command.fallback = 'rg %s -i --files --no-heading --ignore-file ~/.agignore'
" elseif s:grep ==# 'ag'
"   let g:ctrlp_user_command.fallback = 'ag %s -i --nocolor --nogroup -p ~/.agignore -g ""'
" endif

let g:ctrlp_use_caching = 0 " ag is fast enough that CtrlP doesn't need to cache
" TODO: put --ignore files in ~/.agignore
" TODO: more git option - 'cd %s && git ls-files . -co --exclude-standard | grep -v "\.\(png\|jpg\)"'
let g:ctrlp_user_command = {
            \ 'types': {
            \ 1: ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f'],
            \ 2: ['.hg', 'hg --cwd %s locate -I .'],
            \ 3: ['.svn/', 'svn ls file://%s'],
            \ },
            \ 'fallback': 'ag %s -l --nocolor
            \ --ignore out
            \ --ignore .git
            \ --ignore .svn
            \ --ignore .hg
            \ --ignore .DS_Store
            \ --ignore "**/*.pyc"
            \ -p ~/.agignore
            \ -g ""'
            \ }

