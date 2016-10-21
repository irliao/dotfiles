# Vim

## Installation
```bash
brew install vim
ln -s /usr/local/bin/mvim /usr/local/bin/vim
cd ~/.vim/bundle/YouCompleteMe && ./install.py --clang-completer --tern-completer
```

## Files
- vimrc_bak.vim : working version of vimrc
- vimrc_broken.vim : broken, but extremely configured version of vimrc

## Special key representations for Vim key mapping
<BS>           Backspace
<Tab>          Tab
<CR>           Enter
<Enter>        Enter
<Return>       Enter
<Esc>          Escape
<Space>        Space
<Up>           Up arrow
<Down>         Down arrow
<Left>         Left arrow
<Right>        Right arrow
<F1> - <F12>   Function keys 1 to 12
#1, #2..#9,#0  Function keys F1 to F9, F10
<Insert>       Insert
<Del>          Delete
<Home>         Home
<End>          End
<PageUp>       Page-Up
<PageDown>     Page-Down
<bar>          the '|' character, which otherwise needs to be escaped '\|'

## Marks
Traversing Marks
]' jump to next line with a lowercase mark
[' jump to previous line with a lowercase mark
]` jump to next lowercase mark
[` jump to previous lowercase mark

Special Marks
`.	jump to position where last change occurred in current buffer
`"	jump to position where last exited current buffer
`0	jump to position in last file edited (when exited Vim)
`1	like `0 but the previous file (also `2 etc)
''	jump back (to line in current buffer where jumped from)
``	jump back (to position in current buffer where jumped from)
`[ or `]	jump to beginning/end of previously changed or yanked text
`< or `>	jump to beginning/end of last visual selection


