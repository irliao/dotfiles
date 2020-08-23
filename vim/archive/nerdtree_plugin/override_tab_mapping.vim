" Override NERDTree default keymaps

" pressing 't' in NerdTree pane will switch to tab if exist, otherwise make new tab
call NERDTreeAddKeyMap({'key': 'e', 'callback': 'NERDTreeMyOpenInTab', 'scope': 'FileNode', 'override': 1 })
call NERDTreeAddKeyMap({'key': '<cr>', 'callback': 'NERDTreeMyOpenInTab', 'scope': 'FileNode', 'override': 1 })
call NERDTreeAddKeyMap({ 'key': '<2-LeftMouse>', 'callback': 'NERDTreeMyOpenInTab', 'scope': "FileNode", 'override': 1})
function NERDTreeMyOpenInTab(node)
    call a:node.open({'reuse': "all", 'where': 't'})
endfunction

" TODO: broken
" call NERDTreeAddKeyMap({'key': '<cr>', 'callback': 'NERDTreeMyExpandDir', 'scope': 'DirNode', 'override': 1 })
" function NERDTreeMyExpandDir(node)
"     call a:node.open()
" endfunction

